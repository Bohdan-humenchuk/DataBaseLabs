insert into performer values (5, "Volodymir", "2000-10-20", "volodyamort@gmail.com");
insert into book values (11, "test_book_lab_12", 1, 1, 13, "Volodymir", 5);
select * from performer;
select * from book;

drop trigger performer_delete; 
create trigger performer_delete before delete 
on performer for each row 
update book set performer_idperformer = OLD.idperformer - 1, 
performer = (select name from performer where idperformer = OLD.idperformer - 1)
where performer_idperformer = OLD.idperformer;  

delete from performer where idperformer = 5;
select * from performer;  
select * from book; 
delete from book where idbooks = 11; 

######################################################################### 

show index from performer; 

##create index performerINDX on performer (name, emeil); 
##show index from performer; 

explain select name as performer, count(performer.idperformer) 
from performer inner join book 
on book.performer_idperformer = performer.idperformer 
where book.amount < 11 
group by name; 

explain select straight_join name as performer, count(performer.idperformer) 
from performer inner join book 
on book.performer_idperformer = performer.idperformer 
where book.amount < 11 
group by name; 