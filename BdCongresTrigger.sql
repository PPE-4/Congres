-- ------------------------------------------------------------------------------- 
--   Génération des triggers de la base 
--   de données : BdCongres
--   (14/1/2015 9:29:17)
-- ------------------------------------------------------------------------------- 

/* -----------------------------------------------------------------------------
      OUVERTURE DE LA BASE Sous_modèle1
----------------------------------------------------------------------------- */

use BdCongres
go

-- ------------------------------------------------------------------------------- 
--   Table : ACTIVITES
-- ------------------------------------------------------------------------------- 

create trigger TD_ACTIVITES
on ACTIVITES for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de ACTIVITES s'il existe des */
     /* occurrences correspondantes de la table DEROULER. */
     if exists
          (
          select * from deleted,DEROULER
          where
               DEROULER.NUM = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer ACTIVITES car DEROULER existe.'
          goto error
     end
     /* Interdire la suppression d'une occurrence de ACTIVITES s'il existe des */
     /* occurrences correspondantes de la table INSCRIPTION. */
     if exists
          (
          select * from deleted,INSCRIPTION
          where
               INSCRIPTION.NUM_1 = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer ACTIVITES car INSCRIPTION existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_ACTIVITES
on ACTIVITES
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table ACTIVITES s'il existe des */
     /* occurrences correspondantes dans la table DEROULER. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,DEROULER
               where
                    DEROULER.NUM = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier ACTIVITES car DEROULER existe.'
               goto error
          end
     end
     /* Ne pas modifier la clé primaire de la table ACTIVITES s'il existe des */
     /* occurrences correspondantes dans la table INSCRIPTION. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,INSCRIPTION
               where
                    INSCRIPTION.NUM_1 = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier ACTIVITES car INSCRIPTION existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : CONGRESSISTE
-- ------------------------------------------------------------------------------- 

create trigger TD_CONGRESSISTE
on CONGRESSISTE for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de CONGRESSISTE s'il existe des */
     /* occurrences correspondantes de la table INSCRIRE. */
     if exists
          (
          select * from deleted,INSCRIRE
          where
               INSCRIRE.NUM_1 = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer CONGRESSISTE car INSCRIRE existe.'
          goto error
     end
     /* Interdire la suppression d'une occurrence de CONGRESSISTE s'il existe des */
     /* occurrences correspondantes de la table INSCRIPTION. */
     if exists
          (
          select * from deleted,INSCRIPTION
          where
               INSCRIPTION.NUM = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer CONGRESSISTE car INSCRIPTION existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_CONGRESSISTE
on CONGRESSISTE
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la modification de la clé étrangère de la table CONGRESSISTE s'il */
     /* n'existe pas d'occurrence correspondante de la table LIGUES. */
     if
          update(NUM_APPARTIENT)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,LIGUES
          where
               inserted.NUM_APPARTIENT = LIGUES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30007,
                  @errmsg = 'Impossible de mettre à jour CONGRESSISTE car LIGUES n''existe pas.'
               goto error
         end
     end
     /* Interdire la modification de la clé étrangère de la table CONGRESSISTE s'il */
     /* n'existe pas d'occurrence correspondante de la table HOTELS. */
     if
          update(NUM_HEBERGE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,HOTELS
          where
               inserted.NUM_HEBERGE = HOTELS.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30007,
                  @errmsg = 'Impossible de mettre à jour CONGRESSISTE car HOTELS n''existe pas.'
               goto error
         end
     end
     /* Ne pas modifier la clé primaire de la table CONGRESSISTE s'il existe des */
     /* occurrences correspondantes dans la table INSCRIRE. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,INSCRIRE
               where
                    INSCRIRE.NUM_1 = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier CONGRESSISTE car INSCRIRE existe.'
               goto error
          end
     end
     /* Ne pas modifier la clé primaire de la table CONGRESSISTE s'il existe des */
     /* occurrences correspondantes dans la table INSCRIPTION. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,INSCRIPTION
               where
                    INSCRIPTION.NUM = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier CONGRESSISTE car INSCRIPTION existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


create trigger TI_CONGRESSISTE
on CONGRESSISTE 
for insert as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la création d'une occurrence de CONGRESSISTE s'il n'existe pas */
     /* d'occurrence correspondante dans la table LIGUES. */
     if
          update(NUM_APPARTIENT)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,LIGUES
          where
               inserted.NUM_APPARTIENT = LIGUES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer CONGRESSISTE car LIGUES n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de CONGRESSISTE s'il n'existe pas */
     /* d'occurrence correspondante dans la table HOTELS. */
     if
          update(NUM_HEBERGE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,HOTELS
          where
               inserted.NUM_HEBERGE = HOTELS.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer CONGRESSISTE car HOTELS n''existe pas.'
               goto error
          end
     end


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : SESSIONS
-- ------------------------------------------------------------------------------- 

create trigger TD_SESSIONS
on SESSIONS for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de SESSIONS s'il existe des */
     /* occurrences correspondantes de la table INSCRIRE. */
     if exists
          (
          select * from deleted,INSCRIRE
          where
               INSCRIRE.NUM = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer SESSIONS car INSCRIRE existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_SESSIONS
on SESSIONS
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la modification de la clé étrangère de la table SESSIONS s'il */
     /* n'existe pas d'occurrence correspondante de la table THEMES. */
     if
          update(NUM_PORTE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,THEMES
          where
               inserted.NUM_PORTE = THEMES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30007,
                  @errmsg = 'Impossible de mettre à jour SESSIONS car THEMES n''existe pas.'
               goto error
         end
     end
     /* Interdire la modification de la clé étrangère de la table SESSIONS s'il */
     /* n'existe pas d'occurrence correspondante de la table DATE. */
     if
          update(DATEHEURE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,DATE
          where
               inserted.DATEHEURE = DATE.DATEHEURE
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30007,
                  @errmsg = 'Impossible de mettre à jour SESSIONS car DATE n''existe pas.'
               goto error
         end
     end
     /* Interdire la modification de la clé étrangère de la table SESSIONS s'il */
     /* n'existe pas d'occurrence correspondante de la table INTERVENANTS. */
     if
          update(NUM_INTERVIENT)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,INTERVENANTS
          where
               inserted.NUM_INTERVIENT = INTERVENANTS.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30007,
                  @errmsg = 'Impossible de mettre à jour SESSIONS car INTERVENANTS n''existe pas.'
               goto error
         end
     end
     /* Ne pas modifier la clé primaire de la table SESSIONS s'il existe des */
     /* occurrences correspondantes dans la table INSCRIRE. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,INSCRIRE
               where
                    INSCRIRE.NUM = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier SESSIONS car INSCRIRE existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


create trigger TI_SESSIONS
on SESSIONS 
for insert as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la création d'une occurrence de SESSIONS s'il n'existe pas */
     /* d'occurrence correspondante dans la table THEMES. */
     if
          update(NUM_PORTE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,THEMES
          where
               inserted.NUM_PORTE = THEMES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer SESSIONS car THEMES n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de SESSIONS s'il n'existe pas */
     /* d'occurrence correspondante dans la table DATE. */
     if
          update(DATEHEURE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,DATE
          where
               inserted.DATEHEURE = DATE.DATEHEURE
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer SESSIONS car DATE n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de SESSIONS s'il n'existe pas */
     /* d'occurrence correspondante dans la table INTERVENANTS. */
     if
          update(NUM_INTERVIENT)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,INTERVENANTS
          where
               inserted.NUM_INTERVIENT = INTERVENANTS.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer SESSIONS car INTERVENANTS n''existe pas.'
               goto error
          end
     end


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : DATE
-- ------------------------------------------------------------------------------- 

create trigger TD_DATE
on DATE for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de DATE s'il existe des */
     /* occurrences correspondantes de la table DEROULER. */
     if exists
          (
          select * from deleted,DEROULER
          where
               DEROULER.DATEHEURE = deleted.DATEHEURE
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer DATE car DEROULER existe.'
          goto error
     end
     /* Interdire la suppression d'une occurrence de DATE s'il existe des */
     /* occurrences correspondantes de la table INSCRIPTION. */
     if exists
          (
          select * from deleted,INSCRIPTION
          where
               INSCRIPTION.DATEHEURE = deleted.DATEHEURE
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer DATE car INSCRIPTION existe.'
          goto error
     end
     /* Interdire la suppression d'une occurrence de DATE s'il existe des */
     /* occurrences correspondantes de la table SESSIONS. */
     if exists
          (
          select * from deleted,SESSIONS
          where
               SESSIONS.DATEHEURE = deleted.DATEHEURE
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer DATE car SESSIONS existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_DATE
on DATE
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table DATE s'il existe des */
     /* occurrences correspondantes dans la table DEROULER. */
     if
          update(DATEHEURE)
     begin
          if exists
               (
               select * from deleted,DEROULER
               where
                    DEROULER.DATEHEURE = deleted.DATEHEURE
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier DATE car DEROULER existe.'
               goto error
          end
     end
     /* Ne pas modifier la clé primaire de la table DATE s'il existe des */
     /* occurrences correspondantes dans la table INSCRIPTION. */
     if
          update(DATEHEURE)
     begin
          if exists
               (
               select * from deleted,INSCRIPTION
               where
                    INSCRIPTION.DATEHEURE = deleted.DATEHEURE
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier DATE car INSCRIPTION existe.'
               goto error
          end
     end
     /* Ne pas modifier la clé primaire de la table DATE s'il existe des */
     /* occurrences correspondantes dans la table SESSIONS. */
     if
          update(DATEHEURE)
     begin
          if exists
               (
               select * from deleted,SESSIONS
               where
                    SESSIONS.DATEHEURE = deleted.DATEHEURE
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier DATE car SESSIONS existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : LIGUES
-- ------------------------------------------------------------------------------- 

create trigger TD_LIGUES
on LIGUES for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de LIGUES s'il existe des */
     /* occurrences correspondantes de la table CONGRESSISTE. */
     if exists
          (
          select * from deleted,CONGRESSISTE
          where
               CONGRESSISTE.NUM_APPARTIENT = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer LIGUES car CONGRESSISTE existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_LIGUES
on LIGUES
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table LIGUES s'il existe des */
     /* occurrences correspondantes dans la table CONGRESSISTE. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,CONGRESSISTE
               where
                    CONGRESSISTE.NUM_APPARTIENT = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier LIGUES car CONGRESSISTE existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : THEMES
-- ------------------------------------------------------------------------------- 

create trigger TD_THEMES
on THEMES for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de THEMES s'il existe des */
     /* occurrences correspondantes de la table SESSIONS. */
     if exists
          (
          select * from deleted,SESSIONS
          where
               SESSIONS.NUM_PORTE = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer THEMES car SESSIONS existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_THEMES
on THEMES
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table THEMES s'il existe des */
     /* occurrences correspondantes dans la table SESSIONS. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,SESSIONS
               where
                    SESSIONS.NUM_PORTE = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier THEMES car SESSIONS existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : INTERVENANTS
-- ------------------------------------------------------------------------------- 

create trigger TD_INTERVENANTS
on INTERVENANTS for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de INTERVENANTS s'il existe des */
     /* occurrences correspondantes de la table SESSIONS. */
     if exists
          (
          select * from deleted,SESSIONS
          where
               SESSIONS.NUM_INTERVIENT = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer INTERVENANTS car SESSIONS existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_INTERVENANTS
on INTERVENANTS
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table INTERVENANTS s'il existe des */
     /* occurrences correspondantes dans la table SESSIONS. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,SESSIONS
               where
                    SESSIONS.NUM_INTERVIENT = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier INTERVENANTS car SESSIONS existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : HOTELS
-- ------------------------------------------------------------------------------- 

create trigger TD_HOTELS
on HOTELS for delete as
begin
     declare  @errno   int,
                @errmsg  varchar(255)

     /* Interdire la suppression d'une occurrence de HOTELS s'il existe des */
     /* occurrences correspondantes de la table CONGRESSISTE. */
     if exists
          (
          select * from deleted,CONGRESSISTE
          where
               CONGRESSISTE.NUM_HEBERGE = deleted.NUM
          )
     begin
          select @errno  = 30001,
                @errmsg = 'Impossible de supprimer HOTELS car CONGRESSISTE existe.'
          goto error
     end

     return
     error:
          raiserror (@errno, @errmsg,16,1)
          rollback transaction
end
go


create trigger TU_HOTELS
on HOTELS
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Ne pas modifier la clé primaire de la table HOTELS s'il existe des */
     /* occurrences correspondantes dans la table CONGRESSISTE. */
     if
          update(NUM)
     begin
          if exists
               (
               select * from deleted,CONGRESSISTE
               where
                    CONGRESSISTE.NUM_HEBERGE = deleted.NUM
               )
          begin
               select @errno  = 30005,
                  @errmsg = 'Impossible de modifier HOTELS car CONGRESSISTE existe.'
               goto error
          end
     end

     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : INSCRIRE
-- ------------------------------------------------------------------------------- 

create trigger TU_INSCRIRE
on INSCRIRE
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la modification de la clé étrangère référençant la table */
     /* SESSIONS. */

     /* Interdire la modification de la clé étrangère référençant la table */
     /* CONGRESSISTE. */


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


create trigger TI_INSCRIRE
on INSCRIRE 
for insert as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la création d'une occurrence de INSCRIRE s'il n'existe pas */
     /* d'occurrence correspondante dans la table SESSIONS. */
     if
          update(NUM)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,SESSIONS
          where
               inserted.NUM = SESSIONS.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer INSCRIRE car SESSIONS n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de INSCRIRE s'il n'existe pas */
     /* d'occurrence correspondante dans la table CONGRESSISTE. */
     if
          update(NUM_1)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,CONGRESSISTE
          where
               inserted.NUM_1 = CONGRESSISTE.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer INSCRIRE car CONGRESSISTE n''existe pas.'
               goto error
          end
     end


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : DEROULER
-- ------------------------------------------------------------------------------- 

create trigger TU_DEROULER
on DEROULER
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la modification de la clé étrangère référençant la table */
     /* DATE. */

     /* Interdire la modification de la clé étrangère référençant la table */
     /* ACTIVITES. */


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


create trigger TI_DEROULER
on DEROULER 
for insert as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la création d'une occurrence de DEROULER s'il n'existe pas */
     /* d'occurrence correspondante dans la table DATE. */
     if
          update(DATEHEURE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,DATE
          where
               inserted.DATEHEURE = DATE.DATEHEURE
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer DEROULER car DATE n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de DEROULER s'il n'existe pas */
     /* d'occurrence correspondante dans la table ACTIVITES. */
     if
          update(NUM)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,ACTIVITES
          where
               inserted.NUM = ACTIVITES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer DEROULER car ACTIVITES n''existe pas.'
               goto error
          end
     end


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


-- ------------------------------------------------------------------------------- 
--   Table : INSCRIPTION
-- ------------------------------------------------------------------------------- 

create trigger TU_INSCRIPTION
on INSCRIPTION
for update as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la modification de la clé étrangère référençant la table */
     /* CONGRESSISTE. */

     /* Interdire la modification de la clé étrangère référençant la table */
     /* ACTIVITES. */

     /* Interdire la modification de la clé étrangère référençant la table */
     /* DATE. */


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


create trigger TI_INSCRIPTION
on INSCRIPTION 
for insert as
begin
     declare  @numrows int,
                @nullcnt int,
                @validcnt int,
                @errno   int,
                @errmsg  varchar(255)

     select @numrows = @@rowcount

     /* Interdire la création d'une occurrence de INSCRIPTION s'il n'existe pas */
     /* d'occurrence correspondante dans la table CONGRESSISTE. */
     if
          update(NUM)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,CONGRESSISTE
          where
               inserted.NUM = CONGRESSISTE.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer INSCRIPTION car CONGRESSISTE n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de INSCRIPTION s'il n'existe pas */
     /* d'occurrence correspondante dans la table ACTIVITES. */
     if
          update(NUM_1)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,ACTIVITES
          where
               inserted.NUM_1 = ACTIVITES.NUM
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer INSCRIPTION car ACTIVITES n''existe pas.'
               goto error
          end
     end
     /* Interdire la création d'une occurrence de INSCRIPTION s'il n'existe pas */
     /* d'occurrence correspondante dans la table DATE. */
     if
          update(DATEHEURE)
     begin
          select @nullcnt = 0
          select @validcnt = count(*)
          from inserted,DATE
          where
               inserted.DATEHEURE = DATE.DATEHEURE
               
          if @validcnt + @nullcnt != @numrows
          begin
               select @errno  = 30002,
                  @errmsg = 'Impossible d''insérer INSCRIPTION car DATE n''existe pas.'
               goto error
          end
     end


     return
     error:
         raiserror (@errno, @errmsg,16,1)
         rollback transaction
end
go


