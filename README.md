# Observation: How Ruby evaluates strings.

# Ruby actually uses three different types of string values:
# - Heap Strings - Asks extra memory from heap by calling malloc().
# - Strings have same reference i.e str = "s", str1 = str
# - Embedded Strings - New string

# Whenever we create a string value in Ruby, the interpreter goes through a below mentioned algorithm:

1> Is this a new string value? Or a copy of an existing string? If it’s a copy, Ruby creates a String with the same referencec. This is the fastest option, since Ruby only needs a new RString structure.

2> Is this a long string? Or a short string? If the new string value is 23 characters or less, Ruby creates an Embedded String and this is not as fast as a creating the string with same reference but it’s still fast because the 23 characters are simply copied right into the RString structure and there’s no need to call malloc.calling malloc is an expensive operation because it tracks the available memory and when to free them too.

3> Finally, for long string values, 24 characters or more, Ruby creates a Heap String - meaning it calls malloc and gets some new memory from the heap, and then copies the string value there. This is the slowest option and Ruby interpreter always allocates little more memory so that when you change anything to the string it should not call malloc() again.

# The value of RSTRING_EMBED_LEN_MAX was chosen to match the size of the len/ptr/capa values. That’s where the 23 limit comes from.
# Even worse, the value of RSTRING_EMBED_LEN_MAX for a 32-bit machine is less, in fact it's only 11. 

# IMPORTANT:
# It's always a good idea to look into the Ruby C source code so that we can design the software based upon that which will give more performance.

# CODE: Benchmarking Ruby 2.1.0 string allocation based upon "+", "concate", "<<"

Case while creating new string by using 

"+"

Rehearsal --------------------------------------------
20 chars   0.280000   0.000000   0.280000 (  0.280640)
21 chars   0.270000   0.000000   0.270000 (  0.270813)
22 chars   0.280000   0.000000   0.280000 (  0.271196)
23 chars   0.270000   0.000000   0.270000 (  0.278441)
24 chars   0.410000   0.000000   0.410000 (  0.405463)
25 chars   0.400000   0.000000   0.400000 (  0.403870)
----------------------------------- total: 1.910000sec

               user     system      total        real
20 chars   0.280000   0.000000   0.280000 (  0.271439)
21 chars   0.270000   0.000000   0.270000 (  0.269871)
22 chars   0.270000   0.000000   0.270000 (  0.272825)
23 chars   0.280000   0.000000   0.280000 (  0.273103)
24 chars   0.420000   0.000000   0.420000 (  0.413061)
25 chars   0.400000   0.000000   0.400000 (  0.406467)

"concat"

Rehearsal --------------------------------------------
20 chars   0.280000   0.000000   0.280000 (  0.274749)
21 chars   0.270000   0.000000   0.270000 (  0.272985)
22 chars   0.270000   0.000000   0.270000 (  0.265616)
23 chars   0.260000   0.000000   0.260000 (  0.267379)
24 chars   0.260000   0.000000   0.260000 (  0.266343)
25 chars   0.270000   0.000000   0.270000 (  0.266980)
----------------------------------- total: 1.610000sec

               user     system      total        real
20 chars   0.280000   0.000000   0.280000 (  0.273272)
21 chars   0.270000   0.000000   0.270000 (  0.266977)
22 chars   0.270000   0.000000   0.270000 (  0.268927)
23 chars   0.270000   0.000000   0.270000 (  0.266913)
24 chars   0.270000   0.000000   0.270000 (  0.272760)
25 chars   0.270000   0.000000   0.270000 (  0.273072)

"<<"

Rehearsal --------------------------------------------
20 chars   0.250000   0.000000   0.250000 (  0.258534)
21 chars   0.260000   0.000000   0.260000 (  0.254121)
22 chars   0.260000   0.000000   0.260000 (  0.254899)
23 chars   0.250000   0.000000   0.250000 (  0.254967)
24 chars   0.250000   0.000000   0.250000 (  0.254360)
25 chars   0.260000   0.000000   0.260000 (  0.254645)
----------------------------------- total: 1.530000sec

               user     system      total        real
20 chars   0.260000   0.000000   0.260000 (  0.254833)
21 chars   0.250000   0.000000   0.250000 (  0.254816)
22 chars   0.250000   0.000000   0.250000 (  0.255635)
23 chars   0.260000   0.000000   0.260000 (  0.253346)
24 chars   0.260000   0.000000   0.260000 (  0.254474)
25 chars   0.250000   0.000000   0.250000 (  0.253211)

#Important 
  
  # "concat" and "<<" is faster then "+"

