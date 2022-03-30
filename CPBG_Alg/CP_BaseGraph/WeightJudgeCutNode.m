function [Base_Target_Index] = WeightJudgeCutNode(Path, Path_dense)
%WEIGHTJUDGECUTNODE Combined strategy
    Target_flag = false;
    Index = ceil(size(Path, 2)/2);
    Index_left = sum(Path_dense(:, 1:(Index-1)));
    Index_right = sum(Path_dense(:, (Index+1):size(Path, 2)));
    min_dense = min(Index_left, Index_right);
    max_dense = max(Index_left, Index_right);
    temp = min_dense/max_dense;
%     Index_weight = exp(temp) - exp(1);
    Index_weight = (exp(temp)-exp(-temp))./(exp(temp)+exp(-temp));
    if Index_left > Index_right
        Base_Target_Index = Index + round(Index_weight);
    else
        Base_Target_Index = Index - round(Index_weight);
    end
    Temp_max = [];
    Index_left = sum(Path_dense(:, 1:(Base_Target_Index-1)));
    Index_right = sum(Path_dense(:, (Base_Target_Index+1):size(Path, 2)));
    while ~Target_flag
        if Index_left > Index_right 
            Temp_max = false;
            Base_Target_Index = Base_Target_Index - 1;
            Index_left = Index_left - Path_dense(Base_Target_Index);
            Index_right = Index_right + Path_dense(Base_Target_Index);
            if Index_left < Index_right
                Base_Target_Index = Base_Target_Index + 1;
                Target_flag = true;
                break
            end
        else
            Temp_max = true;
            Base_Target_Index = Base_Target_Index + 1;
            Index_left = Index_left + Path_dense(Base_Target_Index);
            Index_right = Index_right - Path_dense(Base_Target_Index);
            if Index_left > Index_right
                Base_Target_Index = Base_Target_Index - 1;
                Target_flag = true;
                break
            end
        end  
    end
end

