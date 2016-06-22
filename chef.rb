## Miercoles 22 de Junio del 2016
## HSP y MRM
## Juntando Fuerzas, Ruby y SQL

require 'sqlite3'


class Chef

attr_accessor :first_name, :last_name, :birthday, :email, :phone

  def initialize(first_name, last_name, birthday, email, phone)
    @id 
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    @created_at = Time.now
    @updated_at = Time.now
  end 

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now'));
        -- Añade aquí más registros
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs;
      SQL
      )
  end

  def self.chef_name(name)
     Chef.db.execute(
      "SELECT * FROM chefs WHERE first_name = ?", name
    )
  end

  def self.chef_id(num_id)
    Chef.db.execute(
          "SELECT * FROM chefs WHERE id = ?",  num_id
        )
  end

  def save
    Chef.db.execute(
    <<-SQL
      INSERT INTO chefs (first_name, last_name, birthday, email, phone, created_at, updated_at) VALUES("#{@first_name}", "#{@last_name}", "#{@birthday}", "#{@email}", "#{@phone}", "#{@created_at}", "#{@updated_at}");
    SQL
    )
  end

  def self.delete(num_id)
    Chef.db.execute(
    "DELETE FROM chefs WHERE id = ?", num_id
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end


end

# primer_chef = Chef.new('Perez', 'Juan', '1987-09-23', 'perez.juan@elfeo.com', '12456389756')
