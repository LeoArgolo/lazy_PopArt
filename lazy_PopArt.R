##--------------------------------------##
## Universidade Federal da Bahia        ##
## Leandro Araujo Argolo                ##
## December - 2017                      ##
##--------------------------------------##                                                         
  
# This was my first R function which I created because I didn't like to manually generate presence/absence matrices for PopArt haplotype networks. Extremely simple but quite useful for me :)  

# To use this I only rename sequence names within the fasta file. They should be written as "sequenceID.VARIABLE". SequenceID should be different for each individual sequence and should not contain a dot in it because "."  is the delimiter that we will use to identify your VARIABLE after the sequenceID. A variable can be any criteria you want to color your haplotypes by (species, lineages, areas, etc).

#### Install/load required packages ####

#install.packages("ape")
#install.packages("stringr")

  library(ape)                     # here we just need the function "read.dna"
  library(stringr)                 # and here we need the function "str_split_fixed"
    
#### Reading the file ####  

leitura = read.dna(                # reads the alignment file in fasta format as a matrix
   file         = "haplo.fas"      
  ,format       = "fasta"          
  ,as.matrix    = TRUE             
  
)  

#### Here's where the magic happens (ikr) ####

popart.matrix =  function(x){      # creates popart.matrix() to generate a presence/absenc matrix based on the sequence names 

# Processando o arquivo:

names = rownames(x)                # get yout sequence names and stores it in a vector

separator = data.frame(names       # stores your delimiter in a dataframe along with sequenceIDs
           ,cbind(                  
            str_split_fixed(names  
           ,pattern = coll(".")    # if you want to, just change "." to any delimiter you want to use
           ,2                      
  )
 )
)

# Generating the binary matrix

traits <<- cbind(separator[1]                           
             ,sapply(levels(separator$X2)                
             ,function(x) as.integer(x == separator$X2  
  )
 )
)   

# Saving the matrix

write.table(traits[2:length(traits)]       # not much to say here. 
            ,"traits.txt"                  
            ,quote = FALSE                 # this is important. We don't want quotation marks here.
            ,row.names = traits$names      
)

return(message("The file traits.txt was saved in your working directory")) # I bet you don't know what this command does, huh?
}

#### Usage ####

popart.matrix(x = leitura)            # as simple as it gets :)