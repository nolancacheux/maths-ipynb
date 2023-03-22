import matplotlib
from sage.matrix.operation_table import OperationTable

class Sandpile():

    # constructor 
    def __init__(self, mat):

    # create the mat attribute 
      self.mat = matrix(mat)

    # representation of the self object 
    def __repr__(self):

    # use the __repr__ method of the sage matrix object 
      return self.mat.__repr__()

    # what to do when calling == between two Sandpile objects 
    def __eq__(self, other):

      # two Sandpile objects are equal if their matrix are the same 
      return self.mat == other.mat

    def topple(self, i, j):
        if self.mat[i, j] >= 4:
            # On enleve les 4 grains de la pile instable 
            self.mat[i, j] -= 4
              #Puis on ajoute à chaque voisins
            if i > 0:
                self.mat[i-1, j] += 1
            if i < self.mat.nrows() - 1:
                self.mat[i+1, j] += 1
            if j > 0:
                self.mat[i, j-1] += 1
            if j < self.mat.ncols() - 1:
                self.mat[i, j+1] += 1

    def show(self):
        #Ici, je peux choisir quelle couleur mettre (j'ai mis les couleurs Junia... Blanc, Violet, Orange)
        startcolor = '#FFFFFF'   #la couleur qui correspond à l'indice le plus petit
        midcolor = '#3c2852'     #la couleur qui correspond à l'indice moyen
        endcolor = '#f25736'     #la couleur qui correspond à l'indice le plus grand
        
        #Enfaite je prends le dégradé donné dans le sujet...
        startcolor = '#FFFFCC'
        midcolor = '#FC8C3B'
        endcolor = '#800026'

        own_cmap1 = matplotlib.colors.LinearSegmentedColormap.from_list( 'own2', [startcolor, midcolor, endcolor] )
        show(matrix_plot(self.mat, cmap = own_cmap1, colorbar = True ))


    def stabilize(self): #renvoie le nombre de renversements
        counter = 0
        while True:
            #  suppose que le tas de sable est stable
            unstable = False
            #  parcourt toutes les cases du tas de sable
            for i in range(self.mat.nrows()):
                for j in range(self.mat.ncols()):
                    # Si la case (i, j) contient 4 grains ou plus, la pile est instable
                    if self.mat[i, j] >= 4:
                        unstable = True
                        break
                if unstable:
                    break
            # Si le tas de sable est stable, sort de la boucle while
            if not unstable:
                break
            # Sinon, renverse une pile instable
            self.topple(i, j)
            counter += 1
        #  renvoie le nombre de renversements nécessaires pour stabiliser le tas de sable
        return counter
    
    def stabilize2(self): #même fonction que stabilize mais renvoie le tas de sable
        #  appelle la fonction stabilize()
        self.stabilize()
        #  renvoie le tas de sable stabilisé
        return self
    
    def stabilizeAnimate(self,delai): #renvoie le nombre de renversements
        counter = 0
        result = []        
        startcolor = '#FFFFCC'
        midcolor = '#FC8C3B'
        endcolor = '#800026'

        own_cmap1 = matplotlib.colors.LinearSegmentedColormap.from_list( 'own2', [startcolor, midcolor, endcolor] )
        
        while True:
            #  suppose que le tas de sable est stable
            unstable = False
            #  parcourt toutes les cases du tas de sable
            for i in range(self.mat.nrows()):
                for j in range(self.mat.ncols()):
                    # Si la case (i, j) contient 4 grains ou plus, la pile est instable
                    if self.mat[i, j] >= 4:
                        unstable = True
                        break
                if unstable:
                    break
            # Si le tas de sable est stable, sort de la boucle while
            if not unstable:
                break
            # Sinon, renverse une pile instable
            self.topple(i, j)
            counter += 1
            if (counter % 15 == 0):
                result.append(matrix_plot(self.mat, cmap = own_cmap1, colorbar = True ))
                #result.append(plot3d(self.mat))
        #  renvoie le nombre de renversements nécessaires pour stabiliser le tas de sable
        
        a=animate(result)
        show(counter)
        return a.show(delay=delai)


    def __add__(self, other):
        # crée une nouvelle matrice qui est la somme des deux matrices
        new_mat = self.mat + other.mat
        #  crée un nouveau tas de sable avec la nouvelle matrice
        new_sandpile = Sandpile(new_mat)
        #  stabilise le nouveau tas de sable
        new_sandpile.stabilize()
        #  renvoie le nouveau tas de sable stabilisé
        return new_sandpile
        
    

print("-= The sandpile class is loaded! =-")
print()
print("Don't forget to reload the class each time the file is modified!")
