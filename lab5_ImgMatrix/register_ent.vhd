library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity register_ent is
    Generic(
        REG_WIDTH : integer := 8
    );
    Port(
        reset    : in std_logic;
        clk      : in std_logic;
        
        data_in  : in std_logic_vector(REG_WIDTH-1 DOWNTO 0);
        data_out : out std_logic_vector(REG_WIDTH-1 DOWNTO 0)
    );
end register_ent;

architecture Behavioral of register_ent is

    component ff_d is -- Definisco ff_d
        Port(
            reset : in std_logic;
            clk   : in std_logic;
    
            d 	  :	in std_logic;
            q 	  : out std_logic
        );
    end component;
    
begin

    ff_d_gen : for I in REG_WIDTH-1 DOWNTO 0 generate
        ff_d_inst : ff_d
        port map(
            reset => reset,
            clk => clk,
            
            d => data_in(I),
            q => data_out(I)
        );
    end generate;
    
end Behavioral;
