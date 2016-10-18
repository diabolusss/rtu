Program dinamicDataIOExample;
Uses Crt, cGlobalHeader, cNNFunctions, uIO;

var     
    nn,nn1:neironNetwork;
    i,j:sizeInt;
BEGIN
    
    NN.receptorCount   := 29;
    NN.neironCount     := 20;    
    NN.positiveLinks   := 4;
    NN.negativeLinks   := 10;
    NN.theta           := 0.6;     
    NN.className       := 'ns';
    
    initWeights(NN.weightW, NN.neironCount);
    initN2RLinks(NN.xyLinkArrayS, NN.receptorCount, NN.neironCount, NN.positiveLinks, NN.negativeLinks);   
    
    printWeights(NN.weightW);
    //printLinks(NN.xyLinkArrayS);

    //save 
    //Save(NN, 'NN.name.dat');
    
    //try to load
    Load(NN1, 'NN.name.dat');   
    
    writeln(NN1.neironCount);
    writeln(NN1.receptorCount);
    writeln(NN1.positiveLinks);
    writeln(NN1.negativeLinks);
    writeln(NN1.theta:1:4);
    writeln(NN1.className);         

    printWeights(NN1.weightW);

    writeln('APPleted');
END.
