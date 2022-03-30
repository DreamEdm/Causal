## Causal Partition Based Graph ##

In this project, we proposed a new method to support more effective and efficient

Here is the **abstract** in article:

Causal discovery is one of the most important research directions of machine learning, aiming to discover the underlying causal relationships in observed data. 

In practice, the time complexity of causal discovery will grow exponentially with increasing variables. 

To alleviate this problem, many methods based on divide-and-conquer strategies were proposed. 

Existing methods usually partition the variables by heuristically using scatted variables to achieve the dividing process, which makes it difficult to minimize vertex cut-set C and then leads to lower performance of causal discovery. 

In this work, we design an elaborated causal partition strategy called {**C**}ausal {**P**}artition {**B**}ase {**G**}raph (CPBG) to solve this problem. 

CPBG uses a set of low-order conditional independence (CI) tests to construct a rough skeleton $S$ corresponding to the observed data and takes a heuristic method to search $S$ for the optimal vertex cut-set $C$. 

Then the observed data can be partitioned into multiple variable subsets. 

We therefore can run a causal discovery method on each part and finally obtain the complete causal structure by merging the partial results. The proposed method is evaluated by various real-world causal datasets.

Experimental results show that the CPBG method outperforms its existing counterparts, which proves that the method can support more effective and efficient causal discovery.

