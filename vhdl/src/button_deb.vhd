------------------------------------------------------------
-- Author(s) : Fabien Marteau <fabien.marteau@armadeus.com>
-- Creation Date : 01/11/2014
------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

Entity button_deb is
    generic (
        clk_freq : natural := 95_000;    -- clk frequency in kHz
        debounce_per_ms : time := 20 ms-- debounce period in ms
    );
    port (
        -- sync design
        clk : in std_logic;
        rst : in std_logic;
        -- input
        button_in : in std_logic;
        button_valid : out std_logic
    );
end entity;

Architecture button_deb_1 of button_deb is
    signal button_in_old : std_logic;
    signal edge : std_logic;
    signal output_s : std_logic;
    CONSTANT MAX_COUNT : natural :=
        (clk_freq * debounce_per_ms/(1000 ms)) + 1;
    signal count : natural range 0 to MAX_COUNT;
begin
    button_valid <= button_in;

    edge_pc: process(clk, rst)
    begin
        if (rst = '1') then
            button_in_old <= button_in;
        elsif rising_edge(clk) then
            edge <= button_in xor button_in_old;
            button_in_old <= button_in;
        end if;
    end process edge_pc;

    -- counter
    count_p : process(clk, rst)
    begin
        if rst = '1' then
            count <= (MAX_COUNT - 1);
        elsif rising_edge(clk) then
            if count /= (MAX_COUNT - 1) then
                count <= count + 1;
            elsif edge = '1' then
                count <= 0;
            end if;
        end if;
    end process count_p;

    -- update output value
    output_s <= button_in when count = (MAX_COUNT - 1) else output_s;
    button_valid <= output_s;

end Architecture button_deb_1;
