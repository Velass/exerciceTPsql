-- a.	Listez les articles dans l’ordre alphabétique des désignations
select * from article ORDER BY DESIGNATION ASC; 

-- b.	Listez les articles dans l’ordre des prix du plus élevé au moins élevé

select * from article ORDER BY PRIX DESC; 

-- c.	Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant

select * from article WHERE DESIGNATION like 'boulon%' ORDER BY PRIX ASC; 

-- d.	Listez tous les articles dont la désignation contient le mot « sachet ».
select * from article WHERE DESIGNATION like '%sachet%'; 

-- e.	Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
select * from article WHERE DESIGNATION like '%sachet%'; 

-- f.	Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
select * from article INNER JOIN fournisseur ON article.ID_FOU = fournisseur.ID
ORDER BY fournisseur.NOM ASC , article.prix desc

-- g.	Listez les articles de la société « Dubois & Fils » 

select * from article where ID_FOU = 3

-- h.	Calculez la moyenne des prix des articles de la société « Dubois & Fils » 

select avg(PRIX) from article where ID_FOU = 3

-- i.   Calculez la moyenne des prix des articles de chaque fournisseur
select avg(PRIX), fournisseur.nom from article INNER JOIN fournisseur ON article.ID_FOU = fournisseur.ID
group by fournisseur.nom

-- j.	Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.

select * from bon where DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12-00-00';

-- k.	Sélectionnez les divers bons de commande qui contiennent des boulons
select * from bon
INNER JOIN compo ON bon.id = compo.id_BON
INNER JOIN article on compo.id_art = article.id
where article.DESIGNATION LIKE '%boulon%'

-- l.	Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.

select * from bon
INNER JOIN compo ON bon.id = compo.id_BON
INNER JOIN article on compo.id_art = article.id
INNER JOIN fournisseur on fournisseur.id = article.id_fou
where article.DESIGNATION LIKE '%boulon%'

-- m.	Calculez le prix total de chaque bon de commande

select bon.id, sum(article.prix * compo.qte) as prix_total
from bon
inner join compo on compo.id_BON = bon.id
inner join article on article.id = compo.id_art
group by bon.id 
order by bon.id asc


-- n.	Comptez le nombre d’articles de chaque bon de commande
select bon.id, sum(compo.qte)
from bon
inner join compo on compo.id_BON = bon.id
inner join article on article.id = compo.id_art
group by bon.id 
order by bon.id asc

--o.	Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande 

select bon.numero, sum(compo.qte) as nbr_article
from bon
inner join compo on compo.id_BON = bon.id
inner join article on article.id = compo.id_art
group by bon.numero 
having nbr_article > 25
order by bon.numero asc

--p.	Calculez le coût total des commandes effectuées sur le mois d’avril 

select bon.numero as num_commande, sum(article.prix * compo.qte) as cout_avril
from bon
inner join compo on compo.id_BON = bon.id
inner join article on article.id = compo.id_art
where MONTH(DATE_CMDE) = 4
group by num_commande