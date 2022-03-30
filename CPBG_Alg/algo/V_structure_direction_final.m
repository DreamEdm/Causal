function [V_struct_skeleton] = V_structure_direction_final(PC_skeleton, edge_ind, condition_set)
%V_STRUCTURE_DIRECTION_FINAL 
%   to find casual graph in total graph 
%   It cannot distinguish Markov equivalence classes
%   This function will use three rules let graph transfrom to PDAG
    V_struct_skeleton = zeros(size(PC_skeleton,1), size(PC_skeleton, 1));
    % inital
    edge_num = size(edge_ind, 2);
    
    for i = 1:edge_num
        X = edge_ind(1, i);
        Y = edge_ind(2, i);
        if X == 0
            break
        end
        % find neighboring vaiablies tha has both X and Y 
        X_x = find(PC_skeleton(X, :) == 1);
        X_y = find(PC_skeleton(:, X) == 1)';
        X_adj = unique([X_x, X_y]);
        Y_x = find(PC_skeleton(Y, :) == 1);
        Y_y = find(PC_skeleton(:, Y) == 1)';
        Y_adj = unique([Y_x, Y_y]);
        % neighbor vaiablies
        neibor_XY = intersect(X_adj, Y_adj);
        is_in_condition = ismember(neibor_XY, condition_set(:, i));
        if sum(is_in_condition) == 0
            V_struct_skeleton(X, neibor_XY) = 1;
            V_struct_skeleton(neibor_XY, X) = 0;
            V_struct_skeleton(Y, neibor_XY) = 1;
            V_struct_skeleton(neibor_XY, Y) = 0;
        else
            K_set = neibor_XY(~is_in_condition);
            if ~isempty(K_set)
                V_struct_skeleton(X, K_set) = 1;
                V_struct_skeleton(K_set, X) = 0;
                V_struct_skeleton(Y, K_set) = 1;
                V_struct_skeleton(K_set, Y) = 0;
            end
        end
    end
end

