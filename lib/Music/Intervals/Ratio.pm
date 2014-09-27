package Music::Intervals::Ratio;
use strict;
use warnings;

our $ratio = {
    '1/1' => q|C unison, perfect prime, tonic|,
    '2/1' => q|C' octave|,
    '3/2' => q|G perfect fifth|,
    '4/3' => q|F perfect fourth|,
    '5/3' => q|A major sixth, BP sixth|,
    '5/4' => q|E major third|,
    '6/5' => q|Eb minor third|,
    '7/3' => q|minimal tenth, BP tenth|,
    '7/4' => q|seventh harmonic|,
    '7/5' => q|septimal or Huygens' tritone, BP fourth|,
    '7/6' => q|septimal minor third|,
    '8/5' => q|Ab minor sixth|,
    '8/7' => q|septimal whole tone|,
    '9/4' => q|major ninth|,
    '9/5' => q|Bb just minor seventh, BP seventh, large minor seventh|,
    '9/7' => q|septimal major third, BP third|,
    '9/8' => q|D major whole tone|,
    '10/7' => q|Euler's tritone, septimal tritone|,
    '10/9' => q|minor whole tone|,
    '11/10' => q|4/5-tone, Ptolemy's second|,
    '11/5' => q|neutral ninth|,
    '11/6' => q|21/4-tone, undecimal neutral seventh, undecimal "median" seventh|,
    '11/7' => q|undecimal augmented fifth, undecimal minor sixth|,
    '11/8' => q|undecimal semi-augmented fourth, undecimal tritone (11th harmonic)|,
    '11/9' => q|undecimal neutral third, undecimal "median" third|,
    '12/11' => q|3/4-tone, undecimal neutral second, undecimal "median" 1/2-step|,
    '12/7' => q|septimal major sixth|,
    '13/10' => q|tridecimal semi-diminished fourth|,
    '13/11' => q|tridecimal minor third|,
    '13/12' => q|tridecimal 2/3-tone, 3/4-tone (Avicenna)|,
    '13/7' => q|16/3-tone|,
    '13/8' => q|tridecimal neutral sixth, overtone sixth|,
    '13/9' => q|tridecimal diminished fifth|,
    '14/11' => q|undecimal diminished fourth or major third|,
    '14/13' => q|2/3-tone|,
    '14/9' => q|septimal minor sixth|,
    '15/11' => q|undecimal augmented fourth|,
    '15/13' => q|tridecimal 5/4-tone|,
    '15/14' => q|major diatonic semitone, Cowell just half-step|,
    '15/7' => q|septimal minor ninth, BP ninth|,
    '15/8' => q|B classic major seventh|,
    '16/11' => q|undecimal semi-diminished fifth|,
    '16/13' => q|tridecimal neutral third|,
    '16/15' => q|minor diatonic semitone, major half-step|,
    '16/7' => q|septimal major ninth|,
    '16/9' => q|Pythagorean small minor seventh|,
    '17/10' => q|septendecimal diminished seventh|,
    '17/11' => q|septendecimal subminor sixth|,
    '17/12' => q|2nd septendecimal tritone|,
    '17/13' => q|septendecimal sub-fourth|,
    '17/14' => q|supraminor third|,
    '17/15' => q|septendecimal whole tone|,
    '17/16' => q|17th harmonic, overtone half-step|,
    '17/8' => q|septendecimal minor ninth|,
    '17/9' => q|septendecimal major seventh|,
    '18/11' => q|undecimal neutral sixth, undecimal "median" sixth|,
    '18/13' => q|tridecimal augmented fourth|,
    '18/17' => q|Arabic lute index finger, ET half-step approximation|,
    '19/10' => q|undevicesimal major seventh|,
    '19/12' => q|undevicesimal minor sixth|,
    '19/15' => q|undevicesimal ditone|,
    '19/16' => q|19th harmonic, overtone minor third|,
    '19/17' => q|quasi-meantone|,
    '19/18' => q|undevicesimal semitone|,
    '20/11' => q|large minor seventh|,
    '20/13' => q|tridecimal semi-augmented fifth|,
    '20/17' => q|septendecimal augmented second|,
    '20/19' => q|small undevicesimal semitone|,
    '20/9' => q|small ninth|,
    '21/11' => q|undecimal major seventh|,
    '21/16' => q|narrow fourth, septimal fourth|,
    '21/17' => q|submajor third|,
    '21/20' => q|minor semitone|,
    '22/13' => q|tridecimal major sixth|,
    '22/15' => q|undecimal diminished fifth|,
    '22/17' => q|septendecimal supermajor third|,
    '22/19' => q|minimal minor third, godzilla third|,
    '22/21' => q|undecimal minor semitone, hard 1/2-step (Ptolemy, Avicenna, Safiud)|,
    '23/12' => q|vicesimotertial major seventh|,
    '23/16' => q|23rd harmonic|,
    '23/18' => q|vicesimotertial major third|,
    '24/13' => q|tridecimal neutral seventh|,
    '24/17' => q|1st septendecimal tritone|,
    '24/19' => q|smaller undevicesimal major third|,
    '25/12' => q|classic augmented octave|,
    '25/14' => q|middle minor seventh|,
    '25/16' => q|classic augmented fifth (G#?)|,
    '25/18' => q|classic augmented fourth|,
    '25/21' => q|BP second, quasi-tempered minor third|,
    '25/24' => q|classic chromatic semitone, minor chroma, minor half-step|,
    '25/9' => q|classic augmented eleventh, BP twelfth|,
    '26/15' => q|tridecimal semi-augmented sixth|,
    '26/17' => q|septendecimal super-fifth|,
    '26/25' => q|1/3-tone (Avicenna)|,
    '27/14' => q|septimal major seventh|,
    '27/16' => q|Pythagorean major sixth|,
    '27/17' => q|septendecimal minor sixth|,
    '27/20' => q|acute fourth|,
    '27/22' => q|neutral third, Zalzal wosta of al-Farabi|,
    '27/23' => q|vicesimotertial minor third|,
    '27/25' => q|large limma, BP small semitone (minor second), alternate Renaissance half-step|,
    '27/26' => q|tridecimal comma|,
    '28/15' => q|grave major seventh|,
    '28/17' => q|submajor sixth|,
    '28/25' => q|middle second|,
    '28/27' => q|Archytas' 1/3-tone, inferior quarter-tone|,
    '29/16' => q|29th harmonic|,
    '30/19' => q|smaller undevicesimal minor sixth|,
    '30/17' => q|septendecimal minor seventh|,
    '31/16' => q|31st harmonic|,
    '31/24' => q|sensi supermajor third|,
    '31/30' => q|31st-partial chroma, superior quarter-tone (Didymus)|,
    '32/15' => q|minor ninth|,
    '32/17' => q|17th subharmonic|,
    '32/19' => q|19th subharmonic|,
    '32/21' => q|wide fifth|,
    '32/23' => q|23rd subharmonic|,
    '32/25' => q|classic diminished fourth|,
    '32/27' => q|Pythagorean minor third|,
    '32/29' => q|29th subharmonic|,
    '32/31' => q|Greek enharmonic 1/4-tone, inferior quarter-tone (Didymus)|,
    '33/25' => q|2 pentatones|,
    '33/26' => q|tridecimal major third|,
    '33/28' => q|undecimal minor third|,
    '33/32' => q|undecimal comma, al-Farabi's 1/4-tone, 33rd harmonic|,
    '34/21' => q|supraminor sixth|,
    '34/27' => q|septendecimal major third|,
    '35/18' => q|septimal semi-diminished octave|,
    '35/24' => q|septimal semi-diminished fifth|,
    '35/27' => q|9/4-tone, septimal semi-diminished fourth|,
    '35/29' => q|doublewide minor third|,
    '35/32' => q|septimal neutral second, 35th harmonic|,
    '35/34' => q|septendecimal 1/4-tone, E.T. 1/4-tone approximation|,
    '36/19' => q|smaller undevicesimal major seventh|,
    '36/25' => q|classic diminished fifth|,
    '36/35' => q|septimal diesis, 1/4-tone, superior quarter-tone (Archytas)|,
    '37/32' => q|37th harmonic|,
    '39/32' => q|39th harmonic, Zalzal wosta of Ibn Sina|,
    '39/38' => q|superior quarter-tone (Eratosthenes)|,
    '40/21' => q|acute major seventh|,
    '40/27' => q|grave fifth, dissonant "wolf" fifth|,
    '40/39' => q|tridecimal minor diesis|,
    '41/32' => q|41st harmonic|,
    '42/25' => q|quasi-tempered major sixth|,
    '43/32' => q|43rd harmonic|,
    '44/27' => q|neutral sixth|,
    '45/32' => q|diatonic tritone, high tritone|,
    '45/44' => q|1/5-tone|,
    '46/45' => q|23rd-partial chroma, inferior quarter-tone (Ptolemy)|,
    '47/32' => q|47th harmonic|,
    '48/25' => q|classic diminished octave|,
    '48/35' => q|septimal semi-augmented fourth|,
    '49/25' => q|BP eighth|,
    '49/30' => q|larger approximation to neutral sixth|,
    '49/32' => q|49th harmonic|,
    '49/36' => q|Arabic lute acute fourth|,
    '49/40' => q|larger approximation to neutral third|,
    '49/44' => q|werckismic minor second|,
    '49/45' => q|BP minor semitone|,
    '49/48' => q|slendro diesis, 1/6-tone|,
    '50/27' => q|grave major seventh|,
    '50/33' => q|3 pentatones|,
    '50/49' => q|Erlich's decatonic comma, tritonic diesis|,
    '51/32' => q|51st harmonic|,
    '51/50' => q|17th-partial chroma|,
    '52/33' => q|tridecimal minor sixth|,
    '53/32' => q|53rd harmonic|,
    '54/35' => q|septimal semi-augmented fifth|,
    '54/49' => q|Zalzal's mujannab|,
    '55/48' => q|keenanismic supermajor second|,
    '55/49' => q|quasi-equal major second|,
    '55/64' => q|55th harmonic|,
    '56/45' => q|narrow perde segah, marvelous major third|,
    '56/55' => q|Ptolemy's enharmonic|,
    '57/32' => q|57th harmonic|,
    '59/32' => q|59th harmonic|,
    '60/49' => q|smaller approximation to neutral third|,
    '61/32' => q|61st harmonic|,
    '61/51' => q|myna third|,
    '62/53' => q|orwell subminor third|,
    '63/25' => q|quasi-equal major tenth, BP eleventh|,
    '63/32' => q|octave - septimal comma, 63rd harmonic|,
    '63/40' => q|narrow minor sixth|,
    '63/50' => q|quasi-equal major third|,
    '63/55' => q|werckismic supermajor second|,
    '64/33' => q|33rd subharmonic|,
    '64/35' => q|septimal neutral seventh|,
    '64/37' => q|37th subharmonic|,
    '64/39' => q|39th subharmonic|,
    '64/45' => q|2nd tritone, low tritone|,
    '64/49' => q|2 septatones or septatonic major third|,
    '64/55' => q|keenanismic subminor third, octave reduced 55th subharmonic|,
    '64/61' => q|harry minor semitone|,
    '64/63' => q|septimal comma, Archytas' comma|,
    '65/64' => q|13th-partial chroma, 65th harmonic|,
    '66/65' => q|winmeanma|,
    '67/64' => q|67th harmonic|,
    '68/35' => q|23/4-tone|,
    '68/65' => q|valentine semitone|,
    '69/64' => q|69th harmonic|,
    '71/57' => q|witchcraft major third|,
    '71/64' => q|71st harmonic|,
    '72/49' => q|Arabic lute grave fifth|,
    '73/60' => q|amity supraminor third|,
    '73/64' => q|73rd harmonic|,
    '75/49' => q|BP fifth|,
    '75/56' => q|marvelous fourth|,
    '75/64' => q|classic augmented second|,
    '76/61' => q|magic major third|,
    '77/60' => q|swetismic supermajor third|,
    '77/64' => q|keenanismic minor third, octave reduced 77th harmonic|,
    '77/72' => q|undecimal secor|,
    '77/76' => q|approximation to 53-tone comma|,
    '78/71' => q|porcupine neutral second|,
    '79/64' => q|79th harmonic|,
    '80/49' => q|smaller approximation to neutral sixth|,
    '80/63' => q|wide major third|,
    '81/44' => q|2nd undecimal neutral seventh|,
    '81/50' => q|acute minor sixth|,
    '81/55' => q|undecimal catafifth|,
    '81/64' => q|Pythagorean major third|,
    '81/68' => q|Persian wosta|,
    '81/70' => q|Al-Hwarizmi's lute middle finger |,
    '81/80' => q|syntonic comma, Didymus comma|,
    '83/64' => q|83rd harmonic|,
    '85/64' => q|85th harmonic|,
    '87/64' => q|87th harmonic|,
    '88/63' => q|werckismic augmented fourth|,
    '88/81' => q|2nd undecimal neutral second|,
    '89/64' => q|89th harmonic|,
    '89/84' => q|approximation to equal semitone|,
    '90/77' => q|swetismic subminor third|,
    '91/59' => q|15/4-tone|,
    '91/64' => q|91st harmonic|,
    '93/64' => q|93rd harmonic|,
    '95/64' => q|95th harmonic|,
    '96/77' => q|undecimal perde segah, keenanismic major third|,
    '96/95' => q|19th-partial chroma|,
    '97/64' => q|97th harmonic|,
    '98/55' => q|quasi-equal minor seventh|,
    '99/64' => q|99th harmonic|,
    '99/70' => q|2nd quasi-equal tritone|,
    '99/98' => q|small undecimal comma, Mothwellsma|,
    '100/63' => q|quasi-equal minor sixth|,
    '100/81' => q|grave major third|,
    '100/97' => q|shrutar quarter tone|,
    '100/99' => q|Ptolemy's comma|,
    '101/64' => q|101st harmonic|,
    '103/64' => q|103rd harmonic|,
    '105/64' => q|septimal neutral sixth, 105th harmonic|,
    '107/64' => q|107th harmonic|,
    '108/77' => q|swetismic augmented fourth|,
    '109/64' => q|109th harmonic|,
    '111/64' => q|111th harmonic|,
    '112/75' => q|marvelous fifth|,
    '113/64' => q|113th harmonic|,
    '115/64' => q|115th harmonic|,
    '117/64' => q|117th harmonic|,
    '119/64' => q|119th harmonic|,
    '121/120' => q|undecimal seconds comma|,
    '121/64' => q|121st harmonic|,
    '123/64' => q|123rd harmonic|,
    '125/108' => q|semi-augmented whole tone|,
    '125/112' => q|classic augmented semitone|,
    '125/64' => q|classic augmented seventh, octave - minor diesis|,
    '125/72' => q|classic augmented sixth|,
    '125/96' => q|classic augmented third|,
    '126/125' => q|small septimal comma|,
    '127/64' => q|127th harmonic|,
    '128/105' => q|septimal neutral third|,
    '128/121' => q|undecimal semitone|,
    '128/125' => q|minor diesis, diesis, diminished second|,
    '128/75' => q|diminished seventh|,
    '128/81' => q|Pythagorean minor sixth|,
    '131/90' => q|13/4-tone|,
    '135/128' => q|major chroma, major limma, limma ascendant|,
    '140/99' => q|quasi-equal tritone|,
    '144/125' => q|classic diminished third|,
    '145/144' => q|29th-partial chroma|,
    '153/125' => q|7/4-tone|,
    '160/81' => q|octave minus syntonic comma|,
    '161/93' => q|19/4-tone|,
    '162/149' => q|Persian neutral second|,
    '192/125' => q|classic diminished sixth|,
    '196/169' => q|consonant interval (Avicenna)|,
    '216/125' => q|semi-augmented sixth|,
    '225/128' => q|augmented sixth|,
    '225/224' => q|septimal kleisma|,
    '231/200' => q|5/4-tone|,
    '241/221' => q|Meshaqah's 3/4-tone|,
    '243/125' => q|octave - maximal diesis|,
    '243/128' => q|Pythagorean major seventh|,
    '243/160' => q|acute fifth|,
    '243/200' => q|acute minor third|,
    '243/224' => q|septimal subtone|,
    '243/242' => q|neutral third comma|,
    '245/243' => q|minor BP diesis|,
    '246/239' => q|Meshaqah's 1/4-tone|,
    '248/243' => q|tricesoprimal comma|,
    '250/153' => q|17/4-tone|,
    '250/243' => q|maximal diesis|,
    '256/135' => q|octave - major chroma|,
    '256/225' => q|diminished third|,
    '256/243' => q|limma, Pythagorean minor second|,
    '256/255' => q|septendecimal kleisma|,
    '261/256' => q|vicesimononal comma|,
    '272/243' => q|Persian whole tone|,
    '273/256' => q|Ibn Sina's minor second|,
    '320/243' => q|grave fourth|,
    '375/256' => q|double augmented fourth|,
    '375/343' => q|BP major semitone|,
    '385/384' => q|undecimal kleisma|,
    '400/243' => q|grave major sixth|,
    '405/256' => q|wide augmented fifth|,
    '512/343' => q|3 septatones or septatonic fifth|,
    '512/375' => q|double diminished fifth|,
    '512/405' => q|narrow diminished fourth|,
    '513/512' => q|undevicesimal comma, Boethius' comma|,
    '525/512' => q|Avicenna enharmonic diesis|,
    '540/539' => q|Swets' comma|,
    '625/324' => q|octave - major diesis|,
    '625/567' => q|BP great semitone|,
    '648/625' => q|major diesis|,
    '675/512' => q|wide augmented third|,
    '687/500' => q|11/4-tone|,
    '729/400' => q|acute minor seventh|,
    '729/512' => q|high Pythagorean tritone|,
    '729/640' => q|acute major second|,
    '729/704' => q|undecimal major diesis|,
    '736/729' => q|vicesimotertial comma|,
    '749/500' => q|ancient Chinese quasi-equal fifth|,
    '750/749' => q|ancient Chinese tempering|,
    '800/729' => q|grave whole tone|,
    '896/891' => q|undecimal semicomma|,
    '1024/675' => q|narrow diminished sixth|,
    '1024/729' => q|Pythagorean diminished fifth, low Pythagorean tritone|,
    '1029/1024' => q|gamelan residue|,
    '1053/1024' => q|tridecimal major diesis|,
    '1125/1024' => q|double augmented prime|,
    '1215/1024' => q|wide augmented second|,
    '1216/1215' => q|Eratosthenes' comma|,
    '1280/729' => q|grave minor seventh|,
    '1288/1287' => q|triaphonisma|,
    '1728/1715' => q|Orwell comma|,
    '1732/1731' => q|approximation to 1 cent|,
    '1875/1024' => q|double augmented sixth|,
    '2025/1024' => q|2 tritones|,
    '2048/1125' => q|double diminished octave|,
    '2048/1215' => q|narrow diminished seventh|,
    '2048/1875' => q|double diminished third|,
    '2048/2025' => q|diaschisma|,
    '2058/2057' => q|xenisma|,
    '2187/1280' => q|acute major sixth|,
    '2187/2048' => q|apotome|,
    '2187/2176' => q|septendecimal comma|,
    '2401/2400' => q|Breedsma|,
    '2560/2187' => q|grave minor third|,
    '3025/3024' => q|lehmerisma|,
    '3125/3072' => q|small diesis|,
    '3125/3087' => q|major BP diesis|,
    '3375/2048' => q|double augmented fifth|,
    '4000/3969' => q|septimal semicomma|,
    '4096/2187' => q|Pythagorean diminished octave|,
    '4096/2401' => q|4 septatones or septatonic major sixth|,
    '4096/3375' => q|double diminished fourth|,
    '4096/4095' => q|tridecimal schisma, Sagittal schismina|,
    '4375/4374' => q|ragisma|,
    '4608/4235' => q|Arabic neutral second|,
    '5120/5103' => q|Beta 5|,
    '5625/4096' => q|double augmented third|,
    '6144/3125' => q|octave - small diesis|,
    '6561/4096' => q|Pythagorean augmented fifth, Pythagorean "schismatic" sixth|,
    '6561/5120' => q|acute major third|,
    '6561/6125' => q|BP major link|,
    '6561/6400' => q|Mathieu superdiesis|,
    '8192/5625' => q|double diminished sixth|,
    '8192/6561' => q|Pythagorean diminished fourth, Pythagorean "schismatic" third|,
    '8192/8019' => q|undecimal minor diesis|,
    '9801/9800' => q|kalisma, Gauss' comma|,
    '10125/8192' => q|double augmented second|,
    '10240/6561' => q|grave minor sixth|,
    '10648/10647' => q|harmonisma|,
    '10935/8192' => q|fourth + schisma, approximation to ET fourth|,
    '15625/15309' => q|great BP diesis|,
    '15625/15552' => q|kleisma, semicomma majeur|,
    '16384/10125' => q|double diminished seventh|,
    '16384/10935' => q|fifth - schisma, approximation to ET fifth|,
    '16875/16807' => q|small BP diesis|,
    '19657/19656' => q|greater harmonisma|,
    '19683/10000' => q|octave - minimal diesis|,
    '19683/10240' => q|acute major seventh|,
    '19683/16384' => q|Pythagorean augmented second|,
    '20000/19683' => q|minimal diesis|,
    '20480/19683' => q|grave minor second|,
    '23232/23231' => q|lesser harmonisma|,
    '32768/16807' => q|5 septatones or septatonic diminished octave|,
    '32768/19683' => q|Pythagorean diminished seventh|,
    '32805/32768' => q|schisma|,
    '59049/32768' => q|Pythagorean augmented sixth|,
    '59049/57344' => q|Harrison's comma|,
    '65536/32805' => q|octave - schisma|,
    '65536/59049' => q|Pythagorean diminished third|,
    '78732/78125' => q|medium semicomma|,
    '83349/78125' => q|BP minor link|,
    '177147/131072' => q|Pythagorean augmented third|,
    '262144/177147' => q|Pythagorean diminished sixth|,
    '390625/196608' => q|octave - Würschmidt's comma|,
    '393216/390625' => q|Würschmidt's comma|,
    '413343/390625' => q|BP small link|,
    '531441/262144' => q|Pythagorean augmented seventh|,
    '531441/524288' => q|Pythagorean comma, ditonic comma|,
    '1048576/531441' => q|Pythagorean diminished ninth|,
    '1594323/1048576' => q|Pythagorean double augmented fourth|,
    '1600000/1594323' => q|kleisma - schisma|,
    '2097152/1594323' => q|Pythagorean double diminished fifth|,
    '2109375/2097152' => q|semicomma, Fokker's comma|,
    '4782969/4194304' => q|Pythagorean double augmented prime|,
    '8388608/4782969' => q|Pythagorean double diminished octave|,
    '14348907/8388608' => q|Pythagorean double augmented fifth|,
    '16777216/14348907' => q|Pythagorean double diminished fourth|,
    '33554432/33480783' => q|Beta 2, septimal schisma|,
    '34171875/33554432' => q|Ampersand's comma|,
    '43046721/33554432' => q|Pythagorean double augmented second|,
    '67108864/43046721' => q|Pythagorean double diminished seventh|,
    '67108864/66430125' => q|diaschisma - schisma|,
    '129140163/67108864' => q|Pythagorean double augmented sixth|,
    '134217728/129140163' => q|Pythagorean double diminished third|,
    '387420489/268435456' => q|Pythagorean double augmented third|,
    '536870912/387420489' => q|Pythagorean double diminished sixth|,
    '1162261467/1073741824' => q|Pythagorean-19 comma|,
    '1162261467/536870912' => q|Pythagorean double augmented seventh|,
    '1224440064/1220703125' => q|parakleisma|,
    '6115295232/6103515625' => q|Vishnu comma|,
    '274877906944/274658203125' => q|semithirds comma|,
    '1001158530539/618750000000' => q|approximation of the golden ratio|,
    '7629394531250/7625597484987' => q|ennealimmal comma|,
    '19073486328125/19042491875328' => q|'19-tone' comma|,
    '123606797749979/200000000000000' => q|approximation of the inverse of the golden ratio|,
    '450359962737049600/450283905890997363' => q|monzisma|,
    '36893488147419103232/36472996377170786403' => q|'41-tone' comma|,
    '19383245667680019896796723/19342813113834066795298816' => q|Mercator's comma|,
};

1;
