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

UPDATE article
LEFT JOIN compo ON article.ID = compo.ID_ART
SET PRIX = PRIX*0.9
WHERE ID_ART IS NULL;
 

-- d.	Une erreur s’est glissée dans les commandes concernant Française d’imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.

UPDATE COMPO 
INNER JOIN ARTICLE ON ARTICLE.ID = COMPO.ID_ART
INNER JOIN FOURNISSEUR ON FOURNISSEUR.ID = ARTICLE.ID_FOU
SET COMPO.QTE = COMPO.QTE * 2 
WHERE FOURNISSEUR.NOM = 'Française d''Imports';

-- e.	Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position.
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU)
VALUES
(12, 'A01', 'Perceuse P1 (très partique) la perceuse', 74.99, 1);
 
UPDATE article
SET designation = concat(substring(designation, 1, position('(' IN designation)-1),
                        substring(designation, position(')' IN designation)+2))
WHERE designation LIKE '%(%)%';
