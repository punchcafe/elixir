defmodule XML do
    import Record
    defrecord(:xmlElement, extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl"))
    defrecord(:xmlAttribute, extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl"))
    defrecord(:xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))
end