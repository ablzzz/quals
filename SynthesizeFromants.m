function R = synthesizeVowels(vowelID)
formants = [1000 2200];
%switch vowelID
%    case 1
%        formants = [1000 700];
%%%% Designing the source %%%%%

%%%% method 1 - pitch contour using which glotal input is created %%%%
%%%% Variations in glottal parameters %%%%



%%%% Create Vocal Tract system %%%%
%%%%% Represent the vocal tract as poles on the z plane %%%
%%%%% Variations in exact format frequencies and distance of the pole from
%%%%% the center %%%%%
formantsAngleZ = 2*pi*formants/sr;
formantsRadius = [0.9 0.94];
polesZ = R.*exp(1j*formantsAngleZ);


%%%% synthesis of vowel %%%%%
vowelWav = filter(1, polesZ, glotWav);
