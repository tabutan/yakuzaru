library(tidyverse)

Dpaper <- read_tsv("data/doctoral-paper.tsv") %>% 
  select("タイトル", "責任表示") %>% 
  rename("title" = "タイトル",
         "author" = "責任表示") %>% 
         #「著」の削除
  mutate(author = str_remove_all(author, "[著]"),
         #記号の削除
         author = str_replace_all(author, pattern ="\\W", replacement=""),
         author = str_replace_all(author,
                                  c("TanakaKoji" = "田中幸治", 
                                    "HayakawaSachiko" = "早川祥子",
                                    "MatsubaraMiki" = "松原幹",
                                    "SuzukiShigeru"  = "鈴木滋",
                                    "HeTianmeng" = "何天萌",
                                    "ShizuItaka" = "伊髙静",
                                    "KuriharaYosuke" = "栗原洋介",
                                    "KojiTanaka" = "田中幸治"))) %>% 
  arrange(desc(title)) %>% 
  distinct(author,.keep_all = TRUE) %>% 
  mutate("saru" = str_detect(title, pattern="ニホンザル|macaques|Macaca")) %>% 
  group_by(saru) %>% 
  summarise("N" = n())

         