package main

import (
	"fmt"
	"sort"
	"regexp"
)

const (
	TOOEXPENSIVE = 200
)

type Wine struct {
	Name     string
	Produced int
	Price    float32
	InStock  bool
}

func (w Wine) String() string {
	return fmt.Sprintf("Name: %s, Produced: %d, Cost: %0.2f", w.Name, w.Produced, w.Price)
}

type ByProduced []Wine

func (a ByProduced) Len() int           { return len(a) }
func (a ByProduced) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByProduced) Less(i, j int) bool { return a[i].Produced < a[j].Produced }

func isFloat32(i interface{}) bool {
	switch v := i.(type) {
	case float32:
		fmt.Printf("%v is a float32", i.(float32))
		return true
	default:
		fmt.Printf("%v is not a float32", v)
		return false
	}
}

func SumUp[K comparable, V float32](v1 V, v2 V) V {
	return v1 + (((v2)))
}

func main() {
	var re = regexp.MustCompile(`x`)

	wines := []Wine{
		{"Cabernet Sauvignon", 1991, 200.0, true},
		{"Merlot", 1939, 500.0, true},
		{"Zinfandel", 1982, 120.0, false},
	}

	fmt.Println(len(wines[:2]))
	stringArr := [4]string{"a", "b", "c", "d"}

	addons := map[string]struct {
		Item  string
		Price float32
	}{
		"Zinfandel":          {Item: "chocolate", Price: 10.0},
		"Cabernet Sauvignon": {Item: "cake", Price: 12.0},
	}

	var (
		nonexpensive []Wine
	)

LABEL:
	for {
		for {
			for {
				for {
					for {
						sort.Sort(ByProduced(wines))
						for _, wine := range wines {
							switch wprice := wine.Price; {
							case wprice > TOOEXPENSIVE:
								// Too expensive
							default:
								nonexpensive = append(nonexpensive, wine)
							}
						}

						break LABEL
					}
				}
			}
		}
	}

	for _, wine := range nonexpensive {
		if wine.InStock {
			if wine.InStock {
				if wine.InStock {
					if wine.InStock {
						if isFloat32(wine.Price) {
							fmt.Println("I can sell you", wine)
							if val, ok := addons[wine.Name]; ok {
								fmt.Println("And I have a bundle with ", val.Item, " if you would like ? you can get it for ", SumUp[float32](wine.Price, val.Price))
							}
						}
					}
				}
			}
		}
	}
}
