-------------------------------------------------------
-- Author : Fabien Marteau <fabien.marteau@armadeus.com
-- Creation Date : 01/11/2014
-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use work.buslib_pkg.all;

Entity buslib_tb is
end entity;

Architecture buslib_tb_1 of buslib_tb is

    CONSTANT CLK_FREQ : natural := 125_000; -- clk freq in kHz

    signal clk : std_logic;
    signal rst : std_logic;

    component avlreg is
    port(
            clk : in std_logic;
            rst : in std_logic;
            -- avalon-mm
            write : in std_logic;
            read  : in std_logic;
            addr  : in std_logic_vector(0 downto 0);
            datawrite : in std_logic_vector(63 downto 0);
            dataread  : out std_logic_vector(63 downto 0);
            byteenable: in std_logic_vector(7 downto 0)
        );
    end component avlreg;
            -- avalon-mm
    signal write : std_logic;
    signal read  : std_logic;
    signal addr  : std_logic_vector(0 downto 0);
    signal datawrite : std_logic_vector(63 downto 0);
    signal dataread  : std_logic_vector(63 downto 0);
    signal byteenable: std_logic_vector(7 downto 0);

begin
    -- system clock --
    clk_p : process
    begin
        clk <= '1';
        wait for (1 sec)/(CLK_FREQ * 2000);
        clk <= '0';
        wait for (1 sec)/(CLK_FREQ * 2000);
    end process clk_p;

    stimulis_p : process
    begin
        rst <= '1';
        wait for 1 ms;
        rst <= '0';
        wait for 1 ms;

        avlmm_write(1, x"cafecafe",
            clk, write, addr, datawrite, byteenable);

        report "<- Simulation Time";
        assert false report "*** End of test ***";
    end process stimulis_p;


    avlreg_con : avlreg
    port map (
        clk        => clk, 
        rst        => rst, 
        write      => write, 
        read       => read, 
        addr       => addr, 
        datawrite  => datawrite, 
        dataread   => dataread, 
        byteenable => byteenable);



end Architecture buslib_tb_1 ;
