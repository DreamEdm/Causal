function [skeleton, names] = GenerateHalfRealSkeleton(chr, counts)
%GENERATEHALFREALSKELETON This function is used to generate the skeleton of a half-real network
%   Generate a half-real network using the Excel file generated by the code
%   conversion in "R-Code"
%   params:
%   chr: This is a parameter used to determine the class of the network,
%   the format is required to be a string, there are two options:
%   chr = 'GBN' (Gaussian Bayesian Networks)
%   chr = 'CLGBN' (Conditional Linear Gaussian Bayesian Networks)
%   counts: Used to select the network that differs between the two
%   options that exist in chr
%   GBN: 'ecoli70', 'magic-niab', 'magic-irri', 'arth150'
%   CLGBN: 'healthcare', 'mehra-complete', 'sangiovese'
    workspace_path = '..\CP_BaseGraph\dataset\Half-real-dataset\Excel_converse_data\';
    Cnode_path = '_node.xlsx';
    Cpar_path = '_parents.xlsx';
    Cchild_path = '_children.xlsx';
    if chr == "GBN"
        if counts == 1
            dataset = 'ecoli70';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
        if counts == 2
            dataset = 'magic-niab';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
        if counts == 3
            dataset = 'magic-irri';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
        if counts == 4
            dataset = 'arth150';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
    end
    if chr == "CLGBN"
        if counts == 1
            dataset = 'healthcare';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
        if counts == 2
            dataset = 'sangiovese';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
        if counts == 3
            dataset = 'mehra-complete';
            node_path = [workspace_path, dataset, Cnode_path];
            par_path = [workspace_path, dataset, Cpar_path];
            child_path = [workspace_path, dataset, Cchild_path];
            [sta, sht] = xlsfinfo(node_path);
            lens = length(sht);
            total_names_cell = {};
            for i = 1:lens
                [~, txt_node, ~] = xlsread(node_path, i);
                total_names_cell{end+1} = txt_node{1};
            end
            total_names = string(total_names_cell);
        end
    end
    nodes = size(total_names_cell, 2);
    skeleton = zeros(nodes,nodes);
    for p = 1:nodes
        [~, txt_parents, ~] = xlsread(par_path, p);
        [~, txt_children, ~] = xlsread(child_path, p);
        % parents
        if ~isempty(txt_parents)
            total_par_index = [];
            for k = 1:length(txt_parents)
                [parindex] = find(total_names == txt_parents{k});
                total_par_index = [total_par_index, parindex];
            end
            skeleton(total_par_index, p) = 1;
        end
        
        % children
        if ~isempty(txt_children)
            total_child_index = [];
            for k = 1:length(txt_children)
                [childindex] = find(total_names == txt_children{k});
                total_child_index = [total_child_index, childindex];
            end
            skeleton(p, total_child_index) = 1;
        end
    end
    names = total_names_cell;
    save_path = ['..\CP_BaseGraph\dataset\Half-real-dataset\Skeleton\', dataset, '.mat'];
    save(save_path, 'skeleton', 'names');
end

