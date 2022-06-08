vegetables = [%w[アスパラガス 独特の風味があり、天ぷら、サラダ、炒め物など、和洋中いずれの料理でもおいしく食べられます。 asparagus.png],
              %w[インゲン 平たいさやいんげんのような見た目で、さやいんげんより甘みが強くシャキシャキとしています。そんなモロッコインゲンは主菜や副菜に大活躍する野菜です。 beans.png],
              %w[オクラ 表面に鋭いうぶ毛を生やしており、触るときにはちょっと注意が必要です。上手に下ごしらえしてあげないと、口の中にチクチクとした食感が残ってしまいます。 okra.png],
              %w[キャベツ 寒玉系は葉がやや固めで、加熱すると甘くなることから、餃子やロールキャベツに向いています。 cabbage.png],
              %w[きゅうり 体を冷やしたくない冬場などは、炒め物がおすすめ。油分と一緒に摂ることでβカロテンを効率よく摂ることができ、免疫力を維持するのに効果が期待できます。 cucumber.png],
              %w[詰め合わせ 採れすぎました。タマネギ、そらまめ、ナス、カリフラワー、ブロッコリーなど入ってます。 vegetables.png],
              %w[ゴーヤー 苦手な方は、種とわたは苦みが強いので、スプーンなどでしっかり取り除き、塩もみしてサッと熱湯にくぐらすと、苦みが抜けます。 bitter_gourd.png],
              %w[スイカ 1玉6Ｌ(約11kg前後) water_melon.png],
              %w[ズッキーニ イタリア料理でおなじみの野菜で、油との相性がよく、料理法は輪切りにして肉類との油炒め、天ぷら、煮物、スープにすると美味です。 zucchini.png],
              %w[トマト 果肉がしっかりしており、濃い赤に色付いています。甘さにこだわり濃厚な味のため、そのまま食べていただくのがベストです。 tomato.png],
              %w[葉物野菜と根菜 セット内容：白菜1玉・大根2本・キャベツ2個・にんじん500g vegetables2.png],
              %w[ナス 皮が薄く、果肉にはたっぷり水分が含まれていて生でもおいしくいただけます。 eggplant.png],
              %w[ピーマン ビタミンCを含む健康野菜です。生のままサラダにして食べるのが理想的ですが、苦みが苦手という方は、煮物や妙め物に使うといいです。  green_pepper.png],
              %w[白菜 定番の鍋物や漬物はもちろん様々な調理法があります！炒めもの、煮物、サラダなどでも活躍を致しますよ！みずみずしくて低カロリーです！ chinese_cabbage.png],
              %w[季節野菜の詰め合わせ 春はそら豆、スナップ、夏はオクラ、秋はさつま芋が有名です！ vegetables3.png]]
puts 'Start inserting seed "crops" ...'
i = 0
User.limit(15).each do |user|
  crop = user.crops.new(name: vegetables[i][0],
                        description: vegetables[i][1],
                        harvested_on: Faker::Date.between(from: 7.days.ago, to: Date.today)
  )
  crop.picture.attach(io: File.open(Rails.root.join("app/assets/images/#{vegetables[i][2]}")), filename: vegetables[i][2])
  crop.save!
  puts "crop#{crop.id} has created!"
  i += 1
end