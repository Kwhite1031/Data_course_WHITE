#Class 10/14/25

library(gapminder)
?gapminder
View(gapminder)
unique(gapminder$country)
unique(gapminder$year)
range(gapminder$year)

## explore the data
## make a good figure and save to your local directory 

structure(gapminder)

Gapobj <- gapminder
Gapobj

Gapobj %>% 
  ggplot(aes(x= year,
             y = lifeExp,
             color = continent)) +
  geom_point(alpha = .2) +
  facet_wrap(~continent) +
  labs(x = 'Year',
       y = 'Life Expectancy (yrs)',
       title = 'Life Expectancy per Year per Continent')


##Yuya example
ggpairs(Gapobj)

##Avg life expectancy by continent
Gapobj %>% 
  group_by(continent, year) %>% 
  summarise(avg_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x = year,
             y = avg_lifeExp,
             color = continent)) +
  geom_point() 

##Add population info to my original plot
Gapobj %>% 
  ggplot(aes(x= year,
             y = lifeExp,
             color = continent)) +
  geom_point(aes(size = pop,
                 shape = continent)) +
  facet_wrap(~continent)

##
Gapobj %>% 
  group_by(continent, year, pop) %>% 
  summarise(avg_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x = year,
             y = avg_lifeExp,
             color = continent)) +
  geom_point(aes(size=pop)) 


##GGanimate @ https://gganimate.com/ 
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

##practice with animation
plot1 <- Gapobj %>% 
  group_by(continent, year) %>% 
  summarise(avg_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x = year,
             y = avg_lifeExp,
             color = continent)) +
  geom_point() 

plot1 %>% 
  transition_time(year)

