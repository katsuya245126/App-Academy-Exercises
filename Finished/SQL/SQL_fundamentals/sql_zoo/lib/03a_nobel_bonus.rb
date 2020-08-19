# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT DISTINCT
           n.yr
      FROM nobels AS n
     WHERE n.subject = 'Physics'
           AND n.yr NOT IN 
              (SELECT DISTINCT
                      n2.yr
                  FROM nobels AS n2
                WHERE n2.subject = 'Chemistry')
  SQL
end
