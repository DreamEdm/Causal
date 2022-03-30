function [TransSet] = TransformToArray_Node(will_trans_node_set, Now_G)
    name_set = table2cell(Now_G.Nodes)';
    [~, Index] = ismember(will_trans_node_set, name_set);
    TransSet = Index;
end

