#import "/src/lib.typ": *


#let criteria = yaml("criteria.yaml")



#rubric(criteria.frontend, levels: 3)


#lorem(30)

#assignment(collect-points: true)[
  Assignment rubric
  #rubric(criteria.backend, levels:4 )
  #rubric(criteria.other, levels: 2)
]

#question(points: 1)[
  #lorem(20)
]

#assignment[

  #question(points: 2)[
    #lorem(20)
  ]


  #question(points: 1)[
    #lorem(20)
  ]
]
