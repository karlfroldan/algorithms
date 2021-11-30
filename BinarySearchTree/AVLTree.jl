module AVLTree 

    include("BinaryTree.jl")
    include("BinarySearchTree.jl")

    using .BinarySearchTree 

    

    function left_rotate!(x :: Node{T}) where T <: Any 
        
        if x.right ≠ nothing
            # First, we have the root node x and its
            # right child y 
            y = x.right 
            
            # y's left child is now x's right child 
            x.right = y.left

            # We bring x down as y's left child 
            y.left = x
        end
    end

    function right_rotate!(x :: Node{T}) where T <: Any 
        
        if x.left ≠ nothing
            y = x.left  
            x.left = y.right 
            y.right = x
        end
    end

end 