function [CP_Cell] = RemoveRedunance(CP_Cell)
    CP_Cell_size = size(CP_Cell, 2);
    CP_Cell_descision = true(1,CP_Cell_size);
    for i = 1:CP_Cell_size
        CP_Cell_length(i) = length(CP_Cell{i});
    end
    for i = 1:CP_Cell_size-1
        for j = i+1:CP_Cell_size
            if CP_Cell_length(j) >= CP_Cell_length(i)
                if length(intersect(CP_Cell{j}, CP_Cell{i})) == CP_Cell_length(i)
                    CP_Cell_descision(i) = 0;
                end
            else
                if length(intersect(CP_Cell{i}, CP_Cell{j})) == CP_Cell_length(j)
                    CP_Cell_descision(j) = 0;
                end
            end
        end
    end
    CP_Cell = CP_Cell(CP_Cell_descision);
end

