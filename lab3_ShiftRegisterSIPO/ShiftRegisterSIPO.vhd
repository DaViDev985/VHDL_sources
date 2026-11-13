library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterSIPO is
    Generic(
        SR_WIDTH : integer := 4
    );
    Port(
        reset    : in std_logic;
        clk      : in std_logic;
        data_in  : in std_logic;
        data_out : out std_logic_vector(SR_WIDTH-1 DOWNTO 0)
    );
end ShiftRegisterSIPO;

architecture Behavioral of ShiftRegisterSIPO is

    component ff_d is -- Definisco ff_d
        Port(
            reset	: in std_logic;
            clk		: in std_logic;
    
            d 	:	in std_logic;
            q 	: out std_logic
        );
    end component;

    signal q_int : std_logic_vector(SR_WIDTH-1 DOWNTO 0); -- Vettore di segnali per poter interfacciare le q con le d all'interno del register
    
begin

    ff_d_inst_N : ff_d -- Faccio il primo flip-flop a parte, in quanto la d si deve interfacciare con l'esterno (data_in)
    port map(
        reset => reset,
        clk => clk,        
        d => data_in,
        q => q_int(SR_WIDTH-1) -- primo elemento del vettore segnale
    );
    
    FF_GEN_1 : for I in SR_WIDTH-2 DOWNTO 0 generate
        ff_d_inst : ff_d
        port map(
            reset => reset,
            clk => clk,
            d => q_int(I+1), --Segnale del flip-flop precedente, +1 perchè gli indici sono al contrario
            q => q_int(I) -- Assegno l'uscita all'elemento corrispondente del vettore segnale
        );
    end generate;
    
    data_out <= q_int; -- Assegno all'uscita di ShiftRegisterSIPO la q dell'ultimo flip-flop (salvata nel segnale q_int(0))

end Behavioral;
