function A = makeAMatrix(clues)
    sizeOfPuzzle = sqrt(length(clues));
    clues = arrangeClues(clues);
    AClue = getAClue(sizeOfPuzzle, clues);
    ACell = getACell(sizeOfPuzzle);
    ABox = Abox(sizeOfPuzzle);
    ARow = Arow(sizeOfPuzzle);
    ACol = Acol(sizeOfPuzzle);
    
    A = [ARow ; ACol ; ABox; ACell ; AClue];
   
end

function clues = arrangeClues( Rawclues )
    cluesHolder = [];
    for i = 1:size(Rawclues, 2)
        if(Rawclues(i) > 0)
            cluesHolder = [cluesHolder Rawclues(i) i];
        end
    end
    clues = cluesHolder;
end


% Script that forms the row logic matrix for an NxN sudoku puzzle

function res = Arow(N)

    Inxn = eye(N);

    row1 = [];
    for i = 1:1:N
        row1 = [row1, Inxn];
    end
    row1 = [row1, zeros(N, N^2*(N-1))];

    rowsMid = [];
    for row = 2:1:N-1
        rowTemp = [zeros(N,(row-1)*N^2)];
        for j = 1:1:N
            rowTemp = [rowTemp, Inxn];
        end
        rowTemp = [rowTemp, zeros(N,(N^3-(row*(N^2))))];
        rowsMid = [rowsMid; rowTemp];
    end

    rowN = [];
    for i = 1:1:N
        rowN = [rowN, Inxn];
    end
    rowN = [zeros(N, N^2*(N-1)), rowN];

    res = [row1; rowsMid; rowN];
    
end


function clueA = getAClue(N, clues)
    holdM = [];
    for i=1:2:size(clues,2)
        holdV = zeros(1,N^3);
        val = clues(i);
        pos = clues(i+1);
        holdV(N*pos - N + val) = 1;
        holdM = [holdM;holdV];
    end
    sum(sum(holdM))
    clueA = holdM;
end


function cellA = getACell(N, ~)
    cells = [];

    for i=1:N^2
        startpos = (i-1)*N + 1;
        cell = zeros(1,N^3);
        cell(1, startpos:startpos + N -1) = ones(1, N);
        cells = [cells ; cell]; 
    end
    size(cells)
    cellA = cells;
end


% Script that forms the row logic matrix for an NxN sudoku puzzle

function res = Acol(N)

    Inxn = eye(N);
    Ocoln = zeros(N, (N^2 - N));

    col1 = [];
    for i = 1:1:N
        col1 = [col1, Inxn, Ocoln];
    end

    colsMid = [];
    for row = 2:1:N-1
        colTemp = [];
        colTemp = [colTemp, zeros(N,N*(row-1))];
        for i = 1:1:N
            if (i ~= 4)
                colTemp = [colTemp, Inxn, Ocoln];
            else
                colTemp = [colTemp, Inxn];
            end
        end
        colTemp = [colTemp, zeros(N,(N^2 - N)-N*(row-1))];
        colsMid = [colsMid; colTemp];
    end

    colN = [];
    for i = 1:1:N
        colN = [colN, Ocoln, Inxn];
    end

    res = [col1; colsMid; colN];
    
end


function res = Abox(N)

    Inxn = eye(N);

    Jn = [];
    for i = 1:1:sqrt(N)
       Jn = [Jn, Inxn];
    end

    box1 = [];
    base = size(Jn,2);
    Oboxn = zeros(N, base);
    for i = 1:1:sqrt(N)
        if (i ~= sqrt(N))
            box1 = [box1, Jn, Oboxn];
        else
            box1 = [box1, Jn];
        end
    end
    rest = size(box1, 2);
    box1 = [box1, zeros(N,N^3-rest)];

    row = 4;

    boxRest = [];
    for row = 2:1:N
        boxTemp = [];
        boxTemp = [boxTemp, zeros(N,(row-1)*base)];
        for i = 1:1:sqrt(N)
            if (i ~= sqrt(N))
                boxTemp = [boxTemp, Jn, Oboxn];
            else
                boxTemp = [boxTemp, Jn];
            end
        end
        rest = size(boxTemp, 2);
        boxTemp = [boxTemp, zeros(N,N^3-rest)];
        boxRest = [boxRest; boxTemp];
    end

    %res = [box1; boxRest];
    N = 9;
    I = eye(N);
    j = [I I I];
    box1 = [zeros(N, 0* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (3*3*N) - 2 *( N^2 - size(j,2)))];
    box2 = [zeros(N, 1* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (4*3*N) - 2 *( N^2 - size(j,2)))];
    box3 = [zeros(N, 2* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (5*3*N) - 2 *( N^2 - size(j,2)))];
    box4 = [zeros(N, 3* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (6*3*N) - 2 *( N^2 - size(j,2)))];
    box5 = [zeros(N, 4* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (7*3*N) - 2 *( N^2 - size(j,2)))];
    box6 = [zeros(N, 5* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (8*3*N) - 2 *( N^2 - size(j,2)))];
    box7 = [zeros(N, 6* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (9*3*N) - 2 *( N^2 - size(j,2)))];
    box8 = [zeros(N, 7* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (10*3*N) - 2 *( N^2 - size(j,2)))];
    box9 = [zeros(N, 8* (3*N)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^2 - size(j,2)) j zeros(N, N^3 - (11*3*N) -2 *( N^2 - size(j,2)))];

    boxes = [box1;box2;box3;box4;box5;box6;box7;box8;box9];
    res = boxes;
end
