create or replace trigger TriggerOnProduit

after INSERT or UPDATE or DELETE on Produit

   FOR EACH ROW
    
    begin
    

      if(inserting) then 
                                       
                    insert into ProduitHistory values (user, :new.idp, SYSDATE, 'insert');
                                 
  
      elsif(deleting) then  

                    insert into ProduitHistory values (user, :old.idp, SYSDATE, 'delete');
 
    
        else        insert into ProduitHistory values (user, :new.idp, SYSDATE, 'update');
    
    end if;
    
    
    
    end;