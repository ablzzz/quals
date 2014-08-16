function vowelWav = synthesizeVowels(vowelID, flag, folder)
    
    switch vowelID %%% formants - denote the formant frequencies, df1, df2 and df3 denote the allowable range
        %%% of formant frequencies for a particular vowel %%%
        case 1   %%% vowel IY - example beet %%%
            formants = [270 2290 3010]; df = [100 500 40];
        case 2   %%% vowel I  - example bit %%%
            formants = [390 1990 2550]; df = [200 650 40]; 
        case 3   %%% vowel E  - example bet %%%
            formants = [530 1840 2480]; df = [200 600 40];
        case 4   %%% vowel AE  - example bat %%%
            formants = [660 1720 2410]; df = [300 600 40];
        case 5   %%% vowel UH  - example but %%%
            formants = [520 1190 2390]; df = [250 400 40];
        case 6   %%% vowel A  - example hot %%%
            formants = [730 1090 2440]; df = [200 300 40];
        case 7   %%% vowel OW  - example bought %%%
            formants = [440 1020 2240]; df = [100 250 40];
        case 8   %%% vowel U  - example foot %%%
            formants = [300 870 2240];  df = [50 200 40];
        case 9   %%% vowel OO  - example boot %%%
            formants = [570 840 2410];  df = [50 200 40];
        case 10  %%% vowel ER  - example bird %%%
            formants = [490 1350 1690]; df = [100 100 40];
    end
    R = [0.95 0.97 0.93]; dr=0.01;
    %%%% Designing the source %%%%%

    if flag == 1; %%% Synthesize only one instance %%%%
        vowelWav = synthesizeVowelInstance(formants, R);
    else
        for j = 1 : 100;
            signVal = ones(1,3);
            randVal = rand(1,3); signVal(randVal < 0.5) = -1; randVal = randVal.*signVal;
            formants = formants + randVal.*(0.20*df) ;
            %R =  R + randVal.*dr;  
            vowelWav = synthesizeVowelInstance(formants, R);
            outFile = [folder '/actvowel_' num2str(vowelID) '_instance_' num2str(j) '_f1_' num2str(floor(formants(1))) '_f2_' num2str(floor(formants(2))) ...
                '_f3_' num2str(floor(formants(3)))]; 
            wavwrite(vowelWav, 16000, outFile);
        end
    end
end  

function vowelWav = synthesizeVowelInstance(formants, R)
%% Funtion to synthesize a vowel using the formants and radius of the formant poles as the argument %%%    
    sr = 16000;
    
    f0 = 220*ones(20,1);
    eng = 0.9*ones(20,1);
    frameShift = 0.015*sr;
    frameSize = 0.025*sr;
    t1 = 0.004; t2 = 0.002;
    glotWav=createImpulse(f0, eng ,frameShift,t1,t2,1);
    
    %%
    nsamps = 16000;
    f0 = 200; % Pitch in Hz
    w0T = 2*pi*f0/sr; % radians per sample
    nharm = floor((sr/2)/f0); % number of harmonics
    sig = zeros(1,nsamps);
    n = 0:(nsamps-1);
    % Synthesize bandlimited impulse train
    for i=1:nharm,
        sig = sig + cos(i*w0T*n);
    end;
    %glotWav = sig;

    %%%% Create Vocal Tract system %%%%
    formantsAngleZ = 2*pi*formants/sr;
    formantsRadius = R;
    polesZ = formantsRadius.*exp(1j*formantsAngleZ);
    tractFilter = real(poly([polesZ,conj(polesZ)]));

    %%%% synthesis of vowel %%%%%
    vowelWav = filter(1, tractFilter, glotWav);
    vowelWav = vowelWav/(1.1*max(abs(vowelWav)));
end
