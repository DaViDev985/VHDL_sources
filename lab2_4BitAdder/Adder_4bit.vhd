library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_4bit is
    Port (
    a   : in std_logic_vector(3 DOWNTO 0);
    b   : in std_logic_vector(3 DOWNTO 0);
    
    sum : out std_logic_vector(3 DOWNTO 0)
    );
end Adder_4bit;

architecture Behavioral of Adder_4bit is

    component HalfAdder is
        Port (
        a   : in std_logic;
        b   : in std_logic;
        
        sum : out std_logic;
        cout: out std_logic
        );
    end component;
    signal c0: std_logic;
    
    component FullAdder is
        Port (
        a   : in std_logic;
        b   : in std_logic;
        cin : in std_logic;
        
        sum : out std_logic;
        cout: out std_logic
        );
    end component;
    signal c1, c2, c3: std_logic;

begin

    HalfAdder_inst : HalfAdder
    port map(
        a => a(0),
        b => b(0),
        
        sum => sum(0),
        cout => c0
    );
    
    FullAdder_inst_1 : FullAdder
    port map(
        a => a(1),
        b => b(1),
        cin => c0,
        
        sum => sum(1),
        cout => c1
    );
    FullAdder_inst_2 : FullAdder
    port map(
        a => a(2),
        b => b(2),
        cin => c1,
        
        sum => sum(2),
        cout => c2
    );
    FullAdder_inst_3 : FullAdder
    port map(
        a => a(3),
        b => b(3),
        cin => c2,
        
        sum => sum(3),
        cout => c3
    );
    

end Behavioral;
