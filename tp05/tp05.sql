SET SQL_SAFE_UPDATES = 0;

-- a.	Mettez en minuscules la désignation de l’article dont l’identifiant est 2

update article
SET DESIGNATION = lower(DESIGNATION)
where ID = 2

-- b.	Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€

update article
SET DESIGNATION = upper(DESIGNATION)
where prix > 10

-- c.	Baissez de 10% le prix de tous les articles qui n’ont pas fait l’objet d’une commande.
-- ps pas sur que ca marche rien ne se passe je verrai avec la correction
update article
SET PRIX = PRIX-(PRIX*10/100)
WHERE NOT EXISTS (
    SELECT 1 FROM COMPO WHERE COMPO.ID_ART = ARTICLE.ID
);

-- d.	Une erreur s’est glissée dans les commandes concernant Française d’imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.

UPDATE COMPO 
INNER JOIN ARTICLE ON ARTICLE.ID = COMPO.ID_ART
INNER JOIN FOURNISSEUR ON FOURNISSEUR.ID = ARTICLE.ID_FOU
SET COMPO.QTE = COMPO.QTE * 2 
WHERE FOURNISSEUR.NOM = 'Française d''Imports';

-- e.	Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position.

