library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_4by1  is
	port(En:in  std_logic;
			 I: in  std_logic_vector(3 downto 0);
			 S: in  std_logic_vector(1 downto 0);
			 Y:	out std_logic);
end entity MUX_4by1;

architecture Struct of MUX_4by1 is
	signal C: std_logic_vector(4 downto 1);
	signal NotS: std_logic_vector(1 downto 0);
begin

	Not1: INVERTER port map (A => S(0), Y => NotS(0)); -- NotS(0) = NOT S(0)
	Not2: INVERTER port map (A => S(1), Y => NotS(1)); -- NotS(1) = NOT S(1)

	A1: AND_4 port map (A => NotS(1), B => NotS(0), C => I(0), D => En, Y => C(1)); -- C(1) = NotS(1)∙ NotS(0)∙ I(0)∙ En
	A2: AND_4 port map (A => NotS(1), B => S(0),    C => I(1), D => En, Y => C(2)); -- C(2) = NotS(1)∙ S(0)   ∙ I(1)∙ En
	A3: AND_4 port map (A => S(1),    B => NotS(0), C => I(2), D => En, Y => C(3)); -- C(3) = S(1)   ∙ NotS(0)∙ I(2)∙ En
	A4: AND_4 port map (A => S(1),    B => S(0),    C => I(3), D => En, Y => C(4)); -- C(4) = S(1)   ∙ S(0)   ∙ I(3)∙ En

	O4: OR_4 port map (A => C(1), B => C(2), C => C(3), D => C(4), Y => Y); -- Y = C(1) + C(2) + C(3) + C(4)

end Struct; 