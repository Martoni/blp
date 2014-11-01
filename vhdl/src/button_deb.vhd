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
end entity;

Architecture button_deb_1 of button_deb is
begin
    button_valid <= button_in;
end Architecture button_deb_1;
