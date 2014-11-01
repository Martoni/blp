-------------------------------------------------------
-- Author : Fabien Marteau <fabien.marteau@armadeus.com
-- Creation Date : 01/11/2014
-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

Entity button_deb_tb is
end entity;

Architecture button_deb_tb_1 of button_deb_tb is

    CONSTANT CLK_FREQ : natural := 95_000; -- clk freq in kHz
    CONSTANT DEBOUNCE_PER_MS : time := 20 ms;

    component button_deb
        generic (
            clk_freq : natural := 95_000;    -- clk frequency in kHz
            debounce_per_ms : time := 20 -- debounce period in ms
        );
        port (
            -- sync design
            clk : in std_logic;
            rst : in std_logic;
            -- input
            button_in : in std_logic;
            button_valid : out std_logic
        );
    end component button_deb;

    signal clk : std_logic;
    signal rst : std_logic;
    signal button_in : std_logic;
    signal button_valid : std_logic;

begin
    -- system clock --
    clk_p : process
    begin
        clk <= '1';
        wait for (1 sec)/(CLK_FREQ * 1000);
        clk <= '0';
        wait for (1 sec)/(CLK_FREQ * 1000);
    end process clk_p;

    button_deb_connect : button_deb
    generic map (
        clk_freq => CLK_FREQ,
        debounce_per_ms => DEBOUNCE_PER_MS
        )
    port map(
        clk => clk,
        rst => rst,
        button_in => button_in,
        button_valid => button_valid
    );

    stimulis_p : process
    begin
        button_in <=  '1';
        wait for 5*DEBOUNCE_PER_MS;
        assert false report "*** End of test ***";
    end process stimulis_p;

end Architecture button_deb_tb_1 ;
