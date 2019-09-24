class FnOscarDashboardProgramStreams < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        if schema_search_path == "\"public\""
          execute <<-SQL.squish
            CREATE OR REPLACE FUNCTION "public"."fn_oscar_dashboard_program_streams"(donor_name varchar DEFAULT 'Save the Children')
              RETURNS TABLE("id" int4, "organization_name" varchar, "name" varchar, "ngo_name" varchar, "completed" bool, enrollment jsonb, "description" text) AS $BODY$
              DECLARE
                sql TEXT := '';
                sch record;
                ps_r record;
              BEGIN
                FOR sch IN
                  SELECT organizations.full_name, organizations.short_name FROM "public"."donors"
                  INNER JOIN "public"."donor_organizations" ON "public"."donor_organizations"."donor_id" = "public"."donors"."id"
                  INNER JOIN "public"."organizations" ON "public"."organizations"."id" = "public"."donor_organizations"."organization_id"
                  WHERE "public"."donors"."name" = donor_name
                LOOP
                  sql := sql || format(
                                  'SELECT %2$s.id, %1$L organization_name, %2$s.name, %2$s.ngo_name,
                                   %2$s.completed, %2$s.enrollment, %2$s.description FROM %1$I.%2$s UNION ',
                                  sch.short_name, 'program_streams');
                END LOOP;

                FOR ps_r IN EXECUTE left(sql, -7)
                LOOP
                  id := ps_r.id;
                  organization_name := ps_r.organization_name;
                  name := ps_r.name;
                  ngo_name := ps_r.ngo_name;
                  completed := ps_r.completed;
                  enrollment := ps_r.enrollment;
                  description := ps_r.description;
                  RETURN NEXT;
                END LOOP;
              END
            $BODY$
              LANGUAGE plpgsql VOLATILE SECURITY DEFINER
              COST 100
              ROWS 1000;

            GRANT EXECUTE ON FUNCTION "public"."fn_oscar_dashboard_program_streams"(varchar) TO "#{ENV['POWER_BI_GROUP']}";
          SQL
        end
      end

      dir.down do
        if schema_search_path == "\"public\""
          execute <<-SQL.squish
            REVOKE EXECUTE ON FUNCTION "public"."fn_oscar_dashboard_program_streams"(varchar) FROM "#{ENV['POWER_BI_GROUP']}";
            DROP FUNCTION IF EXISTS "public"."fn_oscar_dashboard_program_streams"(varchar) CASCADE;
          SQL
        end
      end
    end
  end
end