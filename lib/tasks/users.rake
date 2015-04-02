namespace :users do
  desc "Delete all Users and Create the default again"
  task :rebuild => :environment do
    User.destroy_all
    User.create([
                    {login: "nathalia.casanova@studiare.com.br", name: "Nathalia Casanova", manager: false, password_digest: "$2a$10$kV7sv3W/pGGAB4cFf2aBMef4RMnVTNEsILIYdvAsj4mdlAstsLiIy"},
                    {login: "rafael.zerbini@studiare.com.br", name: "Rafael Zerbini", manager: false, password_digest: "$2a$10$JnMrEMc5y20tromZugmucuCcmvjqeeVGMqYVQqbcYhiFLbQCzEdOK"},
                    {login: "felipe.mattos@studiare.com.br", name: "Felipe Mattos", manager: true, password_digest: "$2a$10$0.SUjWQ7hj4UhfpRHNIUieVMaaplnRWzuq54TNxHT56Ei7ckO13XC"},
                    {login: "murilo.andrade@studiare.com.br", name: "Murilo Andrade", manager: true, password_digest: "$2a$10$nb/KmrSl5Gl/8oRv24qpme3uRpfC9iuxJ9RQKyBzrkU8PYJ7N7VBq"},
                    {login: "ciro.chang@studiare.com.br", name: "Ciro Chang", manager: false, password_digest: "$2a$10$9tW/xUx8NEEgfPIfdPomt.JlWJH7HOyYn50v1yZGgqAmt8ybWLKEu"}
                ])
  end

  desc "Create default admin"
  task :admin_default => :environment do
    user = User.where(name: "admin")
    if user.exists? then user.first.destroy end
    User.create(name: "admin", login:"admin@admin.com", password:"admin123", manager: true)
  end

  desc "destroy admin"
  task :destroy_admin => :environment do
    user = User.where(name: "admin")
    if user.exists? then user.first.destroy end
  end
end