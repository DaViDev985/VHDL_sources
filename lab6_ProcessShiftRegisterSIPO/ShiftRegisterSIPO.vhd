library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterSIPO is
    Port(
        reset : in std_logic;
        clk : in std_logic;
        data_in : in std_logic;
        --data_out range is (X DOWNTO 0) where X >0
        data_out : out std_logic_vector
    );
end ShiftRegisterSIPO;

architecture Behavioral of ShiftRegisterSIPO is
    signal sig_out : std_logic_vector(data_out'range);
begin
    process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then -- set all bits to 0 when reset is 1 (synchronous)
                sig_out <= (Others => '0');
            else -- shift values to the subsequent flipflop
                for I in (sig_out'left - 1) DOWNTO 0 loop
                    sig_out(I) <= sig_out(I+1);
                end loop;
            
                sig_out(sig_out'left) <= data_in; -- copy input to first flipflop after shifting the old values right
            end if;
        end if;
        
    end process;
    
    data_out <= sig_out;

end Behavioral;
