/*
select m.region,t.annee,t.mois,sum(f.qte_vendue)  as somme_des_quantitees ,trunc(avg(f.montantVente)) as avg_montant
from vente f natural join dim_temps t natural join dim_magasin m
where t.mois between 1 and 3
group by  m.region,t.annee,t.mois
order by m.region,t.annee,t.mois
*/

/* Qst 2
select m.region,t.annee,t.mois,sum(f.qte_vendue)  as somme_des_quantitees ,trunc(avg(f.montantVente)) as avg_montant
from vente f natural join dim_temps t natural join dim_magasin m
where t.mois between 1 and 3
group by rollup( m.region,t.annee,t.mois)
order by m.region,t.annee,t.mois
*/


select 
decode(grouping( m.region),1,'toutes les regions',m.region) as region,
decode(grouping(t.annee),1,'toutes les annees',t.annee) as annee,
decode(grouping(t.mois),1,'tous les mois',t.mois) as mois,
sum(f.qte_vendue)  as somme_des_quantit?s ,trunc(avg(f.montantVente)) as avg_montant
from vente f natural join dim_temps t natural join dim_magasin m
where t.mois between 1 and 3
group by cube(m.region,t.annee,t.mois)
order by m.region,t.annee,t.mois

/*Qst 4
select p.nom_produit,m.ville ,p.categorie,m.region,max(f.qte_vendue) as qte_maximale
from vente f natural join dim_temps t natural join dim_produit p natural join dim_magasin m
where t.trimestre = 2 and t.annee = 2019
group by  grouping sets((p.nom_produit,m.ville), (p.categorie, m.region))
order by p.nom_produit,m.ville ,p.categorie,m.region */

/*Qst 5
select p.nom_produit, m.region, sum(f.qte_vendue) as total,
rank() over (partition by p.nom_produit order by sum(f.qte_vendue) desc) as rang_qte,
rank() over (order by sum(f.qte_vendue) desc) as rang_qte_glob
from vente f natural join dim_temps t natural join dim_produit p natural join dim_magasin m
where t.annee = 2018
group by  p.nom_produit, m.region
order by rang_qte_glob*/

/*Qst 6
select * from (select p.categorie, t.annee, p.nom_produit,sum(f.qte_vendue) as total,
rank() over (partition by p.categorie,t.annee order by sum(f.qte_vendue) desc) as rang
from vente f natural join dim_temps t natural join dim_produit p natural join dim_magasin m
where m.region = 'ouest'
group by p.categorie, t.annee, p.nom_produit) where rang <= 2  */


/*Qst 7
select m.nom_magasin,t.annee,t.mois ,sum(f.montantvente) as montant_total,
max(sum(f.montantvente)) over (partition by m.nom_magasin order by t.annee,t.mois rows between 3 PRECEDING and CURRENT row) as Max1,
max(sum(f.montantvente)) over(PARTITION by m.nom_magasin, t.annee order by t.mois rows between unbounded PRECEDING and UNBOUNDED FOLLOWING)as Max2,
max(sum(f.montantvente)) over(PARTITION by m.nom_magasin order by  t.annee,t.mois rows between 12 PRECEDING and 1 PRECEDING)as Max_annee_prec,
sum(sum(f.montantvente)) over(PARTITION by m.nom_magasin,t.annee order by  t.mois rows between 12 PRECEDING and 1 PRECEDING)as Max_annee_prec

from vente f natural join dim_temps t natural join dim_produit p natural join dim_magasin m
group by m.nom_magasin,t.annee,t.mois
order by m.nom_magasin,t.annee,t.mois
*/