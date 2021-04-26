alias MultiString=String?|Array(String)
alias Nint32=Int32?

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

struct Name
    property first, last, suffix, prefix, middle, nick
    def initialize(
        @first : String,
        @last : MultiString|StaticArray(String,2),
        @suffix : MultiString|Int32|Array(Int32|String),
        @prefix : MultiString,
        @middle : MultiString,
        @nick : MultiString
    )
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
end

struct Age
    property age, birthday, alive
    def initialize(
        @age : Nint32,
        @birthday : Birthday,
        @alive : Bool
    )
    end
end

struct XP
    property current, total
    def initialize(
        @current : UInt128,
        @total : UInt128
    )
    end
end

struct Level
    property level,xp
    def initialize(
        @level : Int32|Int64|UInt32|UInt64,
        @xp : XP
    )
    end
end

struct Race
    property name, bloodline
    def initialize(
        @name : String?,
        @bloodline : BloodLine?
    )
    end
end

struct Person
    property name, age, bio, race, sex, level
    def initialize(
        @name : Name,
        @age : Age,
        @bio : String?,
        @race : Race,
        @sex : MultiString|Array(Sex|String)|Sex|Array(Sex),
        @level : Level,
    )
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

puts div

l.each do |i|
    puts i
end

puts div+"\nDone!!!\n"+div