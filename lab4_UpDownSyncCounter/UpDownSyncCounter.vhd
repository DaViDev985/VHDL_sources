library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity UpDownSyncCounter is
    Generic(
        COUNT_WIDTH : integer := 4
    );
    Port (
        reset     : in std_logic;
        clk       : in std_logic;
        
        inc_count : in std_logic;
        dec_count : in std_logic;
        
        count     : out std_logic_vector(COUNT_WIDTH-1 DOWNTO 0) -- Signed
    );
end UpDownSyncCounter;

architecture Behavioral of UpDownSyncCounter is

    component ff_d is -- Definisco ff_d
        Port(
            reset : in std_logic;
            clk   : in std_logic;
    
            d 	  :	in std_logic;
            q 	  : out std_logic
        );
    end component;

    signal count_int : std_logic_vector(COUNT_WIDTH-1 DOWNTO 0);
    signal count_out : std_logic_vector(COUNT_WIDTH-1 DOWNTO 0);
    
begin

    FF_GEN_1 : for I in COUNT_WIDTH-1 DOWNTO 0 generate
        ff_d_inst : ff_d
        port map(
            reset => reset,
            clk => clk,
            d => count_int(I),
            q => count_out(I)
        );
    end generate;
    
    count_int <= std_logic_vector(signed(count_out) + 1) when inc_count = '1' and dec_count = '0' else
                 std_logic_vector(signed(count_out) - 1) when inc_count = '0' and dec_count = '1' else
                 count_out;
    count <= count_out;

end Behavioral;
