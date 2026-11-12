library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity img_matrix is
    Generic (
        IMG_DIM_POW2 : integer := 2
    );
    Port (
        clk        : in std_logic;
        reset      : in std_logic;
        
        in_red     : in std_logic_vector(7 DOWNTO 0);
        in_green   : in std_logic_vector(7 DOWNTO 0);
        in_blue    : in std_logic_vector(7 DOWNTO 0);
        in_x_addr  : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
        in_y_addr  : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
        
        out_gray   : out std_logic_vector(7 DOWNTO 0);
        out_x_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0);
        out_y_addr : in std_logic_vector(IMG_DIM_POW2-1 DOWNTO 0)
    );
end img_matrix;

architecture Behavioral of img_matrix is

    component register_ent is
        Generic(
            REG_WIDTH : integer := 8
        );
        Port(
            reset    : in std_logic;
            clk      : in std_logic;
            
            data_in  : in std_logic_vector(REG_WIDTH-1 DOWNTO 0);
            data_out : out std_logic_vector(REG_WIDTH-1 DOWNTO 0)
        );
    end component;
    
    type img_type is array (0 TO 2**IMG_DIM_POW2-1, 0 TO 2**IMG_DIM_POW2-1) of std_logic_vector(7 DOWNTO 0);
    
    signal d_int: img_type;
    signal q_int: img_type;
    
    signal immagine : img_type;
    signal grey_val : std_logic_vector(7 DOWNTO 0);
    
    signal d_out : std_logic_vector(7 DOWNTO 0);
    
begin
    
    grey_val <= std_logic_vector(
        resize(
            (unsigned("00" & in_red) + unsigned("00" & in_green) + unsigned("00" & in_blue)) / 3, 
            grey_val'length)
        );
    d_out <= q_int( to_integer(unsigned(out_y_addr)) , to_integer(unsigned(out_x_addr)) );

    MATX_GEN : for I in 2**IMG_DIM_POW2-1 DOWNTO 0 generate
        MATy_GEN : for J in 2**IMG_DIM_POW2-1 DOWNTO 0 generate
            reg_inst: register_ent
            port map (
                reset => reset,
                clk => clk,
                
                data_in => d_int(I,J),
                data_out => q_int(I,J)
            );
        end generate;
    end generate;   

    MATX_assign : for I in 2**IMG_DIM_POW2-1 DOWNTO 0 generate
        MATy_assign : for J in 2**IMG_DIM_POW2-1 DOWNTO 0 generate
            d_int(I,J) <= grey_val when (J = unsigned(in_x_addr)) and (I = unsigned(in_y_addr)) else
                          q_int(I,J);
        end generate;
    end generate;
    
    reg_inst: register_ent
            port map (
                reset => reset,
                clk => clk,
                
                data_in => d_out,
                data_out => out_gray
    );
end Behavioral;
