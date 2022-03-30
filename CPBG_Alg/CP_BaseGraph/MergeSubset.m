 function CPBG_Cell = MergeSubset(CPBG_Cell, VertexCutSet)
% to merge subset that it not over threshhold values
    Cell = {};
    for i = 1:size(CPBG_Cell, 2)
        Cell{size(Cell, 2)+1} = setdiff(CPBG_Cell{i}, VertexCutSet);
    end
    for i = 1:size(Cell, 2)
        k = Cell{i};
        Cell_len(:, i) = size(k, 2);
    end
    should_cancel_cell = [];
    for p = 3:size(Cell_len, 2)
        [~, sort_index] = sort(Cell_len, 'descend');
        first_subset_len = Cell_len(sort_index(1));
        second_subset_len = Cell_len(sort_index(2));
        merge_size = second_subset_len + Cell_len(sort_index(p));
        if merge_size <= first_subset_len
            CPBG_Cell{sort_index(2)} = horzcat(CPBG_Cell{sort_index(2)}, Cell{sort_index(p)});
            should_cancel_cell = horzcat(should_cancel_cell, sort_index(p));
        end
    end
    CPBG_Cell(should_cancel_cell) = [];
end

