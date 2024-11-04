SET SQL_SAFE_UPDATES = 0;

-- a.	Supprimer dans la table compo toutes les lignes concernant les bons de commande d’avril 2019
delete compo  from compo
inner join bon on compo.ID_BON = bon.ID
where MONTH(bon.DATE_CMDE) = 4 and YEAR(bon.DATE_CMDE) = 2019;

-- b.	Supprimer dans la table bon tous les bons de commande d’avril 2019
delete from bon
where MONTH(bon.DATE_CMDE) = 4 and YEAR(bon.DATE_CMDE) = 2019;