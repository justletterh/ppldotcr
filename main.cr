require "json"

alias MultiString=String?|Array(String)
alias Nint32=Int32?
alias Nint64=Int64?
alias Nint=Int64?|Int32

div="-"*`tput cols`.to_i64

@[Flags]
enum Sex
    Male
    Female
    Nonbinary
    Agender
    Other
end

@[Flags]
enum BloodLine
    FullBlood
    HalfBlood
    Mixed
    Unknown
    Other
end

@[Flags]
enum Rel
Mother
Father
Sister
Brother
Sibling
Parent
end

struct Name
    property first, last, suffix, prefix, middle, nick
    def initialize(
        @first : String,
        @last : MultiString,
        @suffix : MultiString|Int32|Array(Int32|String),
        @prefix : MultiString,
        @middle : MultiString,
        @nick : MultiString
    )
end
def dict
return {
    first: @first,
    last: @last,
    suffix: @suffix,
    prefix: @prefix,
    middle: @middle,
    nick: @nick
}
end
end

struct Birthday
    property day, month, year
    def initialize(
        @month : Nint32,
        @day : Nint32,
        @year : Nint32
    )
    end
def dict
return {
    month: @month,
    day: @day,
    year: @year
}
end
end

struct Age
    property age, birthday, alive
    def initialize(
        @age : Nint32,
        @birthday : Birthday,
        @alive : Bool
    )
    end
def dict
return {
    age: @age,
    birthday: @birthday.dict,
    alive: @alive
}
end
end

struct XP
    property current, total
    def initialize(
        @current : UInt128,
        @total : UInt128
    )
    end
def dict
return {
    current: @current,
    total: @total
}
end
end

struct Level
    property level,xp
    def initialize(
        @level : Int32|Int64|UInt32|UInt64,
        @xp : XP
    )
    end
def dict
return {
    level: @level,
    xp: @xp.dict
}
end
end

struct Race
    property name, bloodline
    def initialize(
        @name : String?,
        @bloodline : BloodLine
    )
    end
def dict
return {
    name: @name,
    bloodline: @bloodline.to_s
}
end
end

struct Ref
property name, id, rel, alive
def initialize(
    @name : Name,
    @id : Nint64|Int32,
    @rel : MultiString|Rel|Array(Rel)|Array(Rel|String),
    @alive : Bool?
)
end
def dict
return {
    name: @name.dict,
    alive: @alive,
    id: @id,
    rel: @rel
}
end
end

struct Family
property items
def initialize(
    @items : Array(Ref)
)
end
def dict
l=[@items[0].dict]
if @items.size>=2
ll=@items
ll.delete_at(0)
ll.each do |i|
l << i.dict
end
end
return l
end
end

struct Person
    property name, age, bio, race, sex, level, family, id
    def initialize(
        @name : Name,
        @age : Age,
        @bio : String?,
        @race : Race,
        @sex : MultiString|Array(Sex|String)|Sex|Array(Sex),
        @level : Level,
        @family : Family,
        @id : Nint
    )
    end
def dict
return {
    name: @name.dict,
    id: @id,
    age: @age.dict,
    bio: @bio,
    race: @race.dict,
    sex: @sex,
    level: @level.dict,
    family: @family.dict
}
end
end

x=Person.new(
    name: Name.new(
        first: "john",
        last: "doe",
        suffix: [
            1,
            "PhD"
        ],
        prefix: "sir",
        middle: "henry",
        nick: [
            "aytch",
            "h"
        ]
    ),
    id: 8008,
    age: Age.new(
        age: 69,
        birthday: Birthday.new(
            day: 20,
            month: 4,
            year: 1969
        ),
        alive: true
    ),
    bio: "h",
    race: Race.new(
        name: "letter",
        bloodline: BloodLine::FullBlood
    ),
    sex: [
        Sex::Other,
        "letter"
    ],
    level: Level.new(
        level: 6942042069,
        xp: XP.new(
            current: UInt128.new(420),
            total: UInt128.new(69)
        )
    ),
    family: Family.new(
        items: [
            Ref.new(
                name: Name.new(
                    first: "j",
                    last: "jones",
                    middle: nil,
                    prefix: nil,
                    suffix: nil,
                    nick: "j"
                ),
                alive: true,
                id: 0,
                rel: Rel::Mother
            )
        ]
    )
)

l=[
    x,
    x.name,
    x.name.first,
    x.name.last,
    x.name.suffix,
    x.name.prefix,
    x.name.middle,
    x.name.nick,
    x.age,
    x.age.age,
    x.age.birthday,
    x.age.birthday.day,
    x.age.birthday.month,
    x.age.birthday.year,
    x.age.alive,
    x.bio,
    x.race,
    x.race.name,
    x.race.bloodline,
    x.sex,
    x.level,
    x.level.level,
    x.level.xp,
    x.level.xp.current,
    x.level.xp.total
]

hush=true

if !hush
puts div
l.each do |i|
    puts i
end
puts div+"\nDone!!!\n"+div
else
puts x.dict.to_pretty_json()
puts "\nDone!!!"
end
