<center>


# <center>Causal Partition Based Graph</center>

In this project, we proposed a new method to support more effective and efficient causal discovery. 



## Project catalog: 

- CP_BaseGraph: The source code of CPBG and its experimental results.
  - [algo](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/algo): Some necessary baisc algorithms to ensure CPBG doing successful. 
  - [CP_BaseGraph](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/CP_BaseGraph): The core of the method. It describe how to partition the causal graph.
  - [dataset](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/dataset): The network that we get from [bnlearn](https://www.bnlearn.com/), which is used to test our method. 
  - [PK_function](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/PK_function): Some function according to scripts in root directory. 
  - [Testing_Alg](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/Testing_Alg): The code of methods (CP & CAPA) which we compare with CPBG.
  - [workspace](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/workspace): The experimental results of different parameter or strategies. 
  - Others files: Some scripts that we compare with other methods. 

This code supported by Matlab*2018b* or above version. 



If want to recurrent the experimental result in article, please select "**[BinaryInferenceTest.m](https://github.com/DreamEdm/Causal/blob/main/CPBG_Alg/BinaryInferenceTest.m)**" or "**[BinaryInferenceTest_Sample.m](https://github.com/DreamEdm/Causal/blob/main/CPBG_Alg/BinaryInferenceTest_Sample.m)**" in root directory. 

And you should open "**[BinaryInferenceTest_f.m](https://github.com/DreamEdm/Causal/blob/main/CPBG_Alg/PK_function/BinaryInferenceTest_f.m)**" or "**[BinaryInferenceTest_Sample_f.m](https://github.com/DreamEdm/Causal/blob/main/CPBG_Alg/PK_function/BinaryInferenceTest_Sample_f.m)**" in [PK_function](https://github.com/DreamEdm/Causal/tree/main/CPBG_Alg/PK_function). 

Set some parameters such as "*nSample*", "*sizeZ*", then do it!

## Here is the *abstract* in article:

Causal discovery is one of the most important research directions of machine learning, aiming to discover the underlying causal relationships in observed data. 

In practice, the time complexity of causal discovery will grow exponentially with increasing variables. 

To alleviate this problem, many methods based on divide-and-conquer strategies were proposed. 

Existing methods usually partition the variables by heuristically using scatted variables to achieve the dividing process, which makes it difficult to minimize vertex cut-set C and then leads to lower performance of causal discovery. 

In this work, we design an elaborated causal partition strategy called {**C**}ausal {**P**}artition {**B**}ase {**G**}raph (CPBG) to solve this problem. 

CPBG uses a set of low-order conditional independence (CI) tests to construct a rough skeleton $S$ corresponding to the observed data and takes a heuristic method to search $S$ for the optimal vertex cut-set $C$. 

Then the observed data can be partitioned into multiple variable subsets. 

We therefore can run a causal discovery method on each part and finally obtain the complete causal structure by merging the partial results. The proposed method is evaluated by various real-world causal datasets.

Experimental results show that the CPBG method outperforms its existing counterparts, which proves that the method can support more effective and efficient causal discovery.

