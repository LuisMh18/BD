use htron2_migracion_dev;



#Se agrega área usuaria de Sustainable Impact
INSERT INTO cat_user_area (description) VALUES ('Sustainable Impact');
#Se agrega el registro del director de área (Luisa Adame - 111)
INSERT INTO director_area_analysis (user_id,cat_user_area_id,cat_area_id)VALUES (111,18,5);
UPDATE `user` SET cat_user_area_id=18 WHERE id=111;


select * from user where id = 111;
select * from cat_profile;

select * from cat_user_area;

select * from cat_area;
select * from cat_subarea where cat_area_id = 5;
select * from cat_rating_type;

select subarea_ratingtype_product.cat_subarea_id , subarea_ratingtype_product.cat_rating_type_id,
subarea_ratingtype_product.cat_product_id, subarea_ratingtype_product.active,
cat_product.name_sp, cat_product.name_en 
from subarea_ratingtype_product 
left join cat_product on cat_product.id = subarea_ratingtype_product.cat_product_id
where cat_subarea_id = 37 and cat_rating_type_id = 5;

select * from cat_product;


select * from folio;
select * from project;
select * from analysis;
select * from contract_project;

select director_area_analysis.user_id, director_area_analysis.cat_user_area_id, director_area_analysis.cat_area_id,
user.cat_profile_id 
from director_area_analysis 
left join user on user.id  = director_area_analysis.user_id 
where director_area_analysis.cat_user_area_id = 18
and cat_profile_id = 4;


select director_area_analysis.user_id, director_area_analysis.cat_user_area_id, director_area_analysis.cat_area_id,
                                        user.cat_profile_id
                                        from director_area_analysis
                                        left join user on user.id  = director_area_analysis.user_id
                                        where director_area_analysis.cat_user_area_id = 10
                                        and cat_profile_id = 4;

select structuring_agent_comment.id, structuring_agent_comment.user_id, structuring_agent_comment.cat_structuring_agent_id,
structuring_agent_comment.date_in, structuring_agent_comment.comment, structuring_agent_comment.next_action,
structuring_agent_comment.status_alarm,	structuring_agent_comment.cat_status_id,structuring_agent_comment.date_add,
structuring_agent_comment.date_modified,
user.first_name, user.last_name, user.cat_profile_id 
from structuring_agent_comment
left join user on structuring_agent_comment.user_id = user.id
where cat_structuring_agent_id=368 and structuring_agent_comment.cat_status_id=131
order by id desc;

