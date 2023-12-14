select * from Products
select * from Categories

select p1.Productname,p2.Productname
from  products p1	   cross join products p2
where p1.categoryId = 1 and p2.categoryid =8


select * from employees
--Liste aller Mitarbeiter und deren pot. Stellvertreter

select  e1.EmployeeID,e1.lastname, e1.city, e2.city, e2.lastname
from employees e1 inner join employees e2
  on e1.city=e2.city and e1.lastname != e2.lastname
order by 2








