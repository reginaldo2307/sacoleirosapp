namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public','system')
    puts "Executando o setup para o desenvolvimento..."

    %x(rake db:drop)
    %x(rm -rf #{images_path})
    %x(rake db:create)
    %x(rake db:migrate)
    %x(rake db:seed)
    %x(rake dev:generate_admins)
    %x(rake dev:generate_members)
    %x(rake dev:generate_ads)
    
  puts "Setup completado com sucesso"
end
#######################################
  desc "Cria Administradores fakes"
  task generate_admins: :environment do
  	puts "Cadastrando o Administrador Padrão..."

  	10.times do
  		Admin.create!(
  			name: Faker::Name.name,
  			email: Faker::Internet.email,
			password: "123456",
			password_confirmation: "123456",
			role: [0,0,1,1,1,1].sample
		)
  end

  puts "Administrador cadastrado com sucesso"
end
#########################################
# Cria membros 
desc "Cria Membros fakes"
  task generate_members: :environment do
    puts "Cadastrando Membros"



    100.times do
      Member.create!(
        email: Faker::Internet.email,
      password: "123456",
      password_confirmation: "123456"
    )
  end

  puts "Membros cadastrado com sucesso"
end
#########################################
# Cria anúncios
desc "Cria Anúncios fakes"
  task generate_ads: :environment do
    puts "Cadastrando ANÚNCIOS"

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
      member: Member.first,
      category: Category.all.sample,
      price: "#{Random.rand(500)},#{Random.rand(99)}",
      finishi_date: Date.today + Random.rand(90),
      picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
    )
      
    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
      member: Member.all.sample,
      category: Category.all.sample,
      price: "#{Random.rand(500)},#{Random.rand(99)}",
      finishi_date: Date.today + Random.rand(90),
      picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
    )
  end

  puts "ANÚNCIOS cadastrado com sucesso"
end

def markdown_fake
  %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
end

end
