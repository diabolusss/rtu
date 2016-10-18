UNIT UIO;

{$R-,T-,X+,H+,B-}

interface    
    uses cGlobalHeader;
    
    PROCEDURE Save(const NN:neironNetwork;const filename:String);
    PROCEDURE Load(var NN:neironNetwork;const filename:String);
    
implementation uses SysUtils;

    PROCEDURE Save(const NN:neironNetwork;const filename:String);
    VAR
        f: File;
        t,i: SizeInt;
    BEGIN
        writeln('Saving NN to [',filename,'] file');
        
        Assign(f, filename);
        ReWrite(f, 1);
        
        BlockWrite(f, NN.neironCount   , sizeof(NN.neironCount) );
        BlockWrite(f, NN.receptorCount , sizeof(NN.receptorCount) );
        BlockWrite(f, NN.positiveLinks , sizeof(NN.positiveLinks) );
        BlockWrite(f, NN.negativeLinks , sizeof(NN.negativeLinks) );
        BlockWrite(f, NN.theta         , sizeof(NN.theta) );
        BlockWrite(f, NN.className     , sizeof(NN.className) );
        
        t := Length(NN.weightW);
        BlockWrite(f, t, sizeof(t));
        BlockWrite(f, NN.weightW[Low(NN.weightW)], Length(NN.weightW) * sizeof(NN.weightW[0]));
        
        t := Length(NN.xyLinkArrayS);  // outer dimension length
        BlockWrite(f,t,sizeof(t));
        t := Length(NN.xyLinkArrayS[Low(NN.xyLinkArrayS)]); // inner dimension length
        BlockWrite(f,t,sizeof(t)); 
        for i := Low(NN.xyLinkArrayS) to High(NN.xyLinkArrayS) do begin
            BlockWrite(f, NN.xyLinkArrayS[i][Low(NN.xyLinkArrayS[i])], Length(NN.xyLinkArrayS[i]) * sizeof(NN.xyLinkArrayS[0][0]));
        end;
            
        Close(f);
    END;
    
    PROCEDURE Load(var NN:neironNetwork;const filename:String);
    VAR
        f:File;
        t,u,i: SizeInt;
    BEGIN
        writeln('Reading NN from file['+filename+']');
        
        Assign(f, filename);
        Reset(f, 1);
        
        BlockRead(f, NN.neironCount   , sizeof(NN.neironCount) );
        BlockRead(f, NN.receptorCount , sizeof(NN.receptorCount) );
        BlockRead(f, NN.positiveLinks , sizeof(NN.positiveLinks) );
        BlockRead(f, NN.negativeLinks , sizeof(NN.negativeLinks) );
        BlockRead(f, NN.theta         , sizeof(NN.theta) );
        BlockRead(f, NN.className     , sizeof(NN.className) );        
        
        BlockRead(f,t,sizeof(t)); 
        SetLength(NN.weightW, t);
        BlockRead(f, NN.weightW[0], Length(NN.weightW) * sizeof(typeofweight));
        
        
        BlockRead(f, t, sizeof(t));
        BlockRead(f, u, sizeof(u));
        SetLength(NN.xyLinkArrayS, t, u);
        for i := Low(NN.xyLinkArrayS) to High(NN.xyLinkArrayS) do begin
            BlockRead(f, NN.xyLinkArrayS[i][0], Length(NN.xyLinkArrayS[i]) * sizeof(neironNetwork.xyLinkArrayS[0][0]));
        end;
        
        Close(f);    
    END;
    
BEGIN
END.
