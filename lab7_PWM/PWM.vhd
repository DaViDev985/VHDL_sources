library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
    Port (
        reset : in std_logic;
        clk : in std_logic;
        t_on : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
        t_total : in std_logic_vector(8-1 DOWNTO 0); -- UNSIGNED
        pwm_out : out std_logic
    );
end PWM;

architecture Behavioral of PWM is
    
    signal sig_out : std_logic;
    signal sig_counter : integer := 0;
    
begin

    process(clk, reset)
    begin
        if reset = '1' then
        
            sig_counter <= 0;
            sig_out <= '0';
            
        elsif rising_edge(clk) then
        
            if sig_counter <= to_integer(unsigned(t_on)) then
                sig_out <= '1';
            elsif sig_counter > to_integer(unsigned(t_on)) then
                sig_out <= '0';
            end if;
            
            if sig_counter = to_integer(unsigned(t_total)) then
                sig_counter <= 0;
            else
                sig_counter <= sig_counter + 1;
            end if;
            
        end if;
    end process; 
    
    pwm_out <= sig_out;
    
end Behavioral;
