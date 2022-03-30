function [CP_Cell] = TransformToArray(CP_Cell_G, BaseG)
    CP_Cell = {};
    size_Cell = size(CP_Cell_G, 2);
    for i = 1:size_Cell
        will_trans_graph = CP_Cell_G{i};
        will_trans_node_name = table2cell(will_trans_graph.Nodes);
        base_node_name = table2cell(BaseG.Nodes);
        [~, Index] = ismember(will_trans_node_name, base_node_name);
        CP_Cell{size(CP_Cell, 2)+1} = [Index'];
    end
end

