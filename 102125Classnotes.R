#10/21/25 BIOL3100 Class Notes

## make a cool animated plot 
## label the country 

View(gapminder)
df <- gapminder
df


cool_country = c('Kuwait', 'United States', 'Saudi Arabia','Rwanda', 'Argentina', 'Chile', 'Cambodia')
cool_country
unique(df$country)

new_df = df %>% 
  mutate(cool_country = case_when(country %in% cool_country ~ country))
new_df


df %>% 
  mutate(cool_country = case_when(country %in% cool_country ~ country)) %>% 
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent)) +
  labs(x = 'gDP', y = 'sfff') +
  geom_point(aes(size = pop)) +
  geom_text(aes(label = cool_country, vjust = 1.5, hjust = 1.5))

## Leaflet package can let us use maps 

library(leaflet)
leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = -122.4149, lat = 37.7749,
             popup = 'Hello!!!')

## ggmap package


##read in file
##plot rent by state

rent_df <- read.csv('Data/wide_income_rent.csv')
rent_df
view(rent_df)
names(rent_df)
dim(rent_df)

## 1 obs per row
## 1 variable per col

##52 obs 

rent_df_t = as.data.frame(t(rent_df))

rent_df_t_2 = rent_df_t[-1, ]
View(rent_df_t_2)

colnames(rent_df_t_2) <- c('income', 'rent')

rent_df_t_2$state = rownames(rent_df_t_2)

rent_df_t_2 %>% 
  ggplot(aes(x = state,
             y = rent)) +
  geom_bar(stat = 'identity') +
  theme(axis.title.x = element_text(angle = 90, hjust = 1))

?pivot_longer
?pivot_wider


