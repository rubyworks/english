# English::Infinitive
#
#   Copyright (c) 2010 Thomas Sawyer
#   This driviative work is distributed under the terms of the MIT license.
#   See the included LICENSE file for details.
#
# This code was ported from Michael Granger's 'Ruby Linguistics' project:
#
#   Copyright (c) 2003-2008, Michael Granger
#   All rights reserved.
# 
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
# 
#     * Redistributions in binary form must reproduce the above copyright notice,
#       this list of conditions and the following disclaimer in the documentation
#       and/or other materials provided with the distribution.
# 
#     * Neither the name of the author/s, nor the names of the project's
#       contributors may be used to endorse or promote products derived from this
#       software without specific prior written permission.
# 
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
#   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Which in turn was ported from the excellent 'Lingua::EN::Infinitive'
# Perl module by Ron Savage, which is distributed under the following license:
#
#   Australian copyright (c) 1999-2002 Ron Savage.
#    
#   All Programs of mine are 'OSI Certified Open Source Software';
#   you can redistribute them and/or modify them under the terms of
#   The Artistic License, a copy of which is available at:
#   http://www.opensource.org/licenses/index.html
#    
# The Perl module derived from the work of M. Douglas McIlroy:
#
#   Title:   Development of a Spelling List
#   Author:  M. Douglas McIlroy
#   Journal: IEEE Transactions on Communications
#   Issue:   Vol COM-30, No 1, January 1982

require 'english/class'

class English

  # Functions for deriving the infinitive forms of conjugated English words.
  module Infinitive

    # Irregular word => infinitive form
    IRREGULAR = {
        'abided'            => 'abide',
        'abode'             => 'abide',
        'am'                => 'be',
        'are'               => 'be',
        'arisen'            => 'arise',
        'arose'             => 'arise',
        'ate'               => 'eat',
        'awaked'            => 'awake',
        'awoke'             => 'awake',
        'bade'              => 'bid',
        'beaten'            => 'beat',
        'became'            => 'become',
        'been'              => 'be',
        'befallen'          => 'befall',
        'befell'            => 'befall',
        'began'             => 'begin',
        'begat'             => 'beget',
        'begot'             => 'beget',
        'begotten'          => 'beget',
        'begun'             => 'begin',
        'beheld'            => 'behold',
        'bent'              => 'bend',
        'bereaved'          => 'bereave',
        'bereft'            => 'bereave',
        'beseeched'         => 'beseech',
        'besought'          => 'beseech',
        'bespoke'           => 'bespeak',
        'bespoken'          => 'bespeak',
        'bestrewed'         => 'bestrew',
        'bestrewn'          => 'bestrew',
        'bestrid'           => 'bestride',
        'bestridden'        => 'bestride',
        'bestrode'          => 'bestride',
        'betaken'           => 'betake',
        'bethought'         => 'bethink',
        'betook'            => 'betake',
        'betted'            => 'bet',
        'bidden'            => 'bid',
        'bided'             => 'bide',
        'bit'               => 'bite',
        'bitten'            => 'bite',
        'bled'              => 'bleed',
        'blended'           => 'blend',
        'blent'             => 'blend',
        'blessed'           => 'bless',
        'blest'             => 'bless',
        'blew'              => 'blow',
        'blown'             => 'blow',
        'bode'              => 'bide',
        'bore'              => 'bear',
        'born'              => 'bear',
        'borne'             => 'bear',
        'bought'            => 'buy',
        'bound'             => 'bind',
        'bred'              => 'breed',
        'broadcasted'       => 'broadcast',
        'broke'             => 'break',
        'broken'            => 'break',
        'brought'           => 'bring',
        'browbeaten'        => 'browbeat',
        'built'             => 'build',
        'burned'            => 'burn',
        'burnt'             => 'burn',
        'came'              => 'come',
        'caught'            => 'catch',
        'chid'              => 'chide',
        'chidden'           => 'chide',
        'chided'            => 'chide',
        'chose'             => 'choose',
        'chosen'            => 'choose',
        'clad'              => 'clothe',
        'clave'             => 'cleave',
        'cleaved'           => 'cleave',
        'cleft'             => 'cleave',
        'clothed'           => 'clothe',
        'clove'             => 'cleave',
        'cloven'            => 'cleave',
        'clung'             => 'cling',
        'costed'            => 'cost',
        'could'             => 'can',
        'crept'             => 'creep',
        'crew'              => 'crow',
        'crowed'            => 'crow',
        'dealt'             => 'deal',
        'did'               => 'do',
        'done'              => 'do',
        'dove'              => 'dive',
        'drank'             => 'drink',
        'drawn'             => 'draw',
        'dreamed'           => 'dream',
        'dreamt'            => 'dream',
        'drew'              => 'draw',
        'driven'            => 'drive',
        'drove'             => 'drive',
        'drunk'             => 'drink',
        'dug'               => 'dig',
        'dwelled'           => 'dwell',
        'dwelt'             => 'dwell',
        'eaten'             => 'eat',
        'fallen'            => 'fall',
        'fed'               => 'feed',
        'fell'              => 'fall',
        'felt'              => 'feel',
        'fled'              => 'flee',
        'flew'              => 'fly',
        'flown'             => 'fly',
        'flung'             => 'fling',
        'forbad'            => 'forbid',
        'forbade'           => 'forbid',
        'forbidden'         => 'forbid',
        'forbore'           => 'forbear',
        'forborne'          => 'forbear',
        'fordid'            => 'fordo',
        'fordone'           => 'fordo',
        'forecasted'        => 'forecast',
        'foregone'          => 'forego',
        'foreknew'          => 'foreknow',
        'foreknown'         => 'foreknow',
        'foreran'           => 'forerun',
        'foresaw'           => 'foresee',
        'foreshowed'        => 'foreshow',
        'foreshown'         => 'foreshow',
        'foretold'          => 'foretell',
        'forewent'          => 'forego',
        'forgave'           => 'forgive',
        'forgiven'          => 'forgive',
        'forgot'            => 'forget',
        'forgotten'         => 'forget',
        'forsaken'          => 'forsake',
        'forseen'           => 'foresee',
        'forsook'           => 'forsake',
        'forswore'          => 'forswear',
        'forsworn'          => 'forswear',
        'fought'            => 'fight',
        'found'             => 'find',
        'froze'             => 'freeze',
        'frozen'            => 'freeze',
        'gainsaid'          => 'gainsay',
        'gave'              => 'give',
        'gilded'            => 'gild',
        'gilt'              => 'gild',
        'girded'            => 'gird',
        'girt'              => 'gird',
        'given'             => 'give',
        'gone'              => 'go',
        'got'               => 'get',
        'gotten'            => 'get',
        'graved'            => 'grave',
        'graven'            => 'grave',
        'grew'              => 'grow',
        'ground'            => 'grind',
        'grown'             => 'grow',
        'had'               => 'have',
        'hamstringed'       => 'hamstring',
        'hamstrung'         => 'hamstring',
        'hanged'            => 'hang',
        'heard'             => 'hear',
        'heaved'            => 'heave',
        'held'              => 'hold',
        'hewed'             => 'hew',
        'hewn'              => 'hew',
        'hid'               => 'hide',
        'hidden'            => 'hide',
        'hove'              => 'heave',
        'hung'              => 'hang',
        'inlaid'            => 'inlay',
        'is'                => 'be',
        'kept'              => 'keep',
        'kneeled'           => 'kneel',
        'knelt'             => 'kneel',
        'knew'              => 'know',
        'knitted'           => 'knit',
        'known'             => 'know',
        'laded'             => 'lade',
        'laden'             => 'lade',
        'laid'              => 'lay',
        'lain'              => 'lie',
        'lay'               => 'lie',
        'leaned'            => 'lean',
        'leant'             => 'lean',
        'leaped'            => 'leap',
        'leapt'             => 'leap',
        'learned'           => 'learn',
        'learnt'            => 'learn',
        'led'               => 'lead',
        'left'              => 'leave',
        'lent'              => 'lend',
        'lighted'           => 'light',
        'lit'               => 'light',
        'lost'              => 'lose',
        'made'              => 'make',
        'meant'             => 'mean',
        'melted'            => 'melt',
        'met'               => 'meet',
        'might'             => 'may',
        'misdealt'          => 'misdeal',
        'misgave'           => 'misgive',
        'misgiven'          => 'misgive',
        'mislaid'           => 'mislay',
        'misled'            => 'mislead',
        'mistaken'          => 'mistake',
        'mistook'           => 'mistake',
        'misunderstood'     => 'misunderstand',
        'molten'            => 'melt',
        'mowed'             => 'mow',
        'mown'              => 'mow',
        'outate'            => 'outeat',
        'outbade'           => 'outbid',
        'outbidden'         => 'outbid',
        'outbred'           => 'outbreed',
        'outdid'            => 'outdo',
        'outdone'           => 'outdo',
        'outeaten'          => 'outeat',
        'outfought'         => 'outfight',
        'outgone'           => 'outgo',
        'outgrew'           => 'outgrow',
        'outgrown'          => 'outgrow',
        'outlaid'           => 'outlay',
        'outran'            => 'outrun',
        'outridden'         => 'outride',
        'outrode'           => 'outride',
        'outsat'            => 'outsit',
        'outshone'          => 'outshine',
        'outshot'           => 'outshoot',
        'outsold'           => 'outsell',
        'outspent'          => 'outspend',
        'outthrew'          => 'outthrow',
        'outthrown'         => 'outthrow',
        'outwent'           => 'outgo',
        'outwore'           => 'outwear',
        'outworn'           => 'outwear',
        'overate'           => 'overeat',
        'overbade'          => 'overbid',
        'overbidden'        => 'overbid',
        'overblew'          => 'overblow',
        'overblown'         => 'overblow',
        'overbore'          => 'overbear',
        'overborn'          => 'overbear',
        'overborne'         => 'overbear',
        'overbought'        => 'overbuy',
        'overbuilt'         => 'overbuild',
        'overcame'          => 'overcome',
        'overdid'           => 'overdo',
        'overdone'          => 'overdo',
        'overdrawn'         => 'overdraw',
        'overdrew'          => 'overdraw',
        'overdriven'        => 'overdrive',
        'overdrove'         => 'overdrive',
        'overeaten'         => 'overeat',
        'overfed'           => 'overfeed',
        'overflew'          => 'overfly',
        'overflown'         => 'overfly',
        'overgrew'          => 'overgrow',
        'overgrown'         => 'overgrow',
        'overhanged'        => 'overhang',
        'overheard'         => 'overhear',
        'overhung'          => 'overhang',
        'overladed'         => 'overlade',
        'overladen'         => 'overlade',
        'overlaid'          => 'overlay',
        'overlain'          => 'overlie',
        'overlay'           => 'overlie',
        'overleaped'        => 'overleap',
        'overleapt'         => 'overleap',
        'overpaid'          => 'overpay',
        'overran'           => 'overrun',
        'overridden'        => 'override',
        'overrode'          => 'override',
        'oversaw'           => 'oversee',
        'overseen'          => 'oversee',
        'oversewed'         => 'oversew',
        'oversewn'          => 'oversew',
        'overshot'          => 'overshoot',
        'overslept'         => 'oversleep',
        'overspent'         => 'overspend',
        'overtaken'         => 'overtake',
        'overthrew'         => 'overthrow',
        'overthrown'        => 'overthrow',
        'overtook'          => 'overtake',
        'overwinded'        => 'overwind',
        'overwound'         => 'overwind',
        'overwritten'       => 'overwrite',
        'overwrote'         => 'overwrite',
        'paid'              => 'pay',
        'partaken'          => 'partake',
        'partook'           => 'partake',
        'prechose'          => 'prechoose',
        'prechosen'         => 'prechoose',
        'proved'            => 'prove',
        'proven'            => 'prove',
        'quitted'           => 'quit',
        'ran'               => 'run',
        'rang'              => 'ring',
        'reaved'            => 'reave',
        'rebuilt'           => 'rebuild',
        'reeved'            => 'reeve',
        'reft'              => 'reave',
        'relaid'            => 'relay',
        'rent'              => 'rend',
        'repaid'            => 'repay',
        'retold'            => 'retell',
        'ridded'            => 'rid',
        'ridden'            => 'ride',
        'risen'             => 'rise',
        'rived'             => 'rive',
        'riven'             => 'rive',
        'rode'              => 'ride',
        'rose'              => 'rise',
        'rove'              => 'reeve',
        'rung'              => 'ring',
        'said'              => 'say',
        'sang'              => 'sing',
        'sank'              => 'sink',
        'sat'               => 'sit',
        'saw'               => 'see',
        'sawed'             => 'saw',
        'sawn'              => 'saw',
        'seen'              => 'see',
        'sent'              => 'send',
        'sewed'             => 'sew',
        'sewn'              => 'sew',
        'shaken'            => 'shake',
        'shaved'            => 'shave',
        'shaven'            => 'shave',
        'sheared'           => 'shear',
        'shined'            => 'shine',
        'shod'              => 'shoe',
        'shoed'             => 'shoe',
        'shone'             => 'shine',
        'shook'             => 'shake',
        'shorn'             => 'shear',
        'shot'              => 'shoot',
        'showed'            => 'show',
        'shown'             => 'show',
        'shrank'            => 'shrink',
        'shredded'          => 'shred',
        'shrived'           => 'shrive',
        'shriven'           => 'shrive',
        'shrove'            => 'shrive',
        'shrunk'            => 'shrink',
        'shrunken'          => 'shrink',
        'slain'             => 'slay',
        'slept'             => 'sleep',
        'slew'              => 'slay',
        'slid'              => 'slide',
        'slidden'           => 'slide',
        'slung'             => 'sling',
        'slunk'             => 'slink',
        'smelled'           => 'smell',
        'smelt'             => 'smell',
        'smitten'           => 'smite',
        'smote'             => 'smite',
        'snuck'             => 'sneak',
        'sold'              => 'sell',
        'sought'            => 'seek',
        'sowed'             => 'sow',
        'sown'              => 'sow',
        'span'              => 'spin',
        'spat'              => 'spit',
        'sped'              => 'speed',
        'speeded'           => 'speed',
        'spelled'           => 'spell',
        'spelt'             => 'spell',
        'spent'             => 'spend',
        'spilled'           => 'spill',
        'spilt'             => 'spill',
        'spoiled'           => 'spoil',
        'spoilt'            => 'spoil',
        'spoke'             => 'speak',
        'spoken'            => 'speak',
        'sprang'            => 'spring',
        'sprung'            => 'spring',
        'spun'              => 'spin',
        'stank'             => 'stink',
        'staved'            => 'stave',
        'stole'             => 'steal',
        'stolen'            => 'steal',
        'stood'             => 'stand',
        'stove'             => 'stave',
        'strewed'           => 'strew',
        'strewn'            => 'strew',
        'stricken'          => 'strike',
        'strid'             => 'stride',
        'stridden'          => 'stride',
        'strived'           => 'strive',
        'striven'           => 'strive',
        'strode'            => 'stride',
        'strove'            => 'strive',
        'struck'            => 'strike',
        'strung'            => 'string',
        'stuck'             => 'stick',
        'stung'             => 'sting',
        'stunk'             => 'stink',
        'sung'              => 'sing',
        'sunk'              => 'sink',
        'sunken'            => 'sink',
        'swam'              => 'swim',
        'sweated'           => 'sweat',
        'swelled'           => 'swell',
        'swept'             => 'sweep',
        'swollen'           => 'swell',
        'swore'             => 'swear',
        'sworn'             => 'swear',
        'swum'              => 'swim',
        'swung'             => 'swing',
        'taken'             => 'take',
        'taught'            => 'teach',
        'thought'           => 'think',
        'threw'             => 'throw',
        'thrived'           => 'thrive',
        'thriven'           => 'thrive',
        'throve'            => 'thrive',
        'thrown'            => 'throw',
        'told'              => 'tell',
        'took'              => 'take',
        'tore'              => 'tear',
        'torn'              => 'tear',
        'trod'              => 'tread',
        'trodden'           => 'tread',
        'unbent'            => 'unbend',
        'unbound'           => 'unbind',
        'unbuilt'           => 'unbuild',
        'underbought'       => 'underbuy',
        'underfed'          => 'underfeed',
        'undergone'         => 'undergo',
        'underlaid'         => 'underlay',
        'underlain'         => 'underlie',
        'underlay'          => 'underlie',
        'underpaid'         => 'underpay',
        'underran'          => 'underrun',
        'undershot'         => 'undershoot',
        'undersold'         => 'undersell',
        'understood'        => 'understand',
        'undertaken'        => 'undertake',
        'undertook'         => 'undertake',
        'underwent'         => 'undergo',
        'underwritten'      => 'underwrite',
        'underwrote'        => 'underwrite',
        'undid'             => 'undo',
        'undone'            => 'undo',
        'undrawn'           => 'undraw',
        'undrew'            => 'undraw',
        'unfroze'           => 'unfreeze',
        'unfrozen'          => 'unfreeze',
        'ungirded'          => 'ungird',
        'ungirt'            => 'ungird',
        'unhanged'          => 'unhang',
        'unhung'            => 'unhang',
        'unknitted'         => 'unknit',
        'unladed'           => 'unlade',
        'unladen'           => 'unlade',
        'unlaid'            => 'unlay',
        'unlearned'         => 'unlearn',
        'unlearnt'          => 'unlearn',
        'unmade'            => 'unmake',
        'unreeved'          => 'unreeve',
        'unrove'            => 'unreeve',
        'unsaid'            => 'unsay',
        'unslung'           => 'unsling',
        'unspoke'           => 'unspeak',
        'unspoken'          => 'unspeak',
        'unstrung'          => 'unstring',
        'unstuck'           => 'unstick',
        'unswore'           => 'unswear',
        'unsworn'           => 'unswear',
        'untaught'          => 'unteach',
        'unthought'         => 'unthink',
        'untrod'            => 'untread',
        'untrodden'         => 'untread',
        'unwinded'          => 'unwind',
        'unwound'           => 'unwind',
        'unwove'            => 'unweave',
        'unwoven'           => 'unweave',
        'upbuilt'           => 'upbuild',
        'upheld'            => 'uphold',
        'uprisen'           => 'uprise',
        'uprose'            => 'uprise',
        'upswept'           => 'upsweep',
        'upswung'           => 'upswing',
        'waked'             => 'wake',
        'was'               => 'be',
        'waylaid'           => 'waylay',
        'wedded'            => 'wed',
        'went'              => 'go',
        'wept'              => 'weep',
        'were'              => 'be',
        'wetted'            => 'wet',
        'winded'            => 'wind',
        'wist'              => 'wit',
        'wot'               => 'wit',
        'withdrawn'         => 'withdraw',
        'withdrew'          => 'withdraw',
        'withheld'          => 'withhold',
        'withstood'         => 'withstand',
        'woke'              => 'wake',
        'woken'             => 'wake',
        'won'               => 'win',
        'wore'              => 'wear',
        'worked'            => 'work',
        'worn'              => 'wear',
        'wound'             => 'wind',
        'wove'              => 'weave',
        'woven'             => 'weave',
        'written'           => 'write',
        'wrote'             => 'write',
        'wrought'           => 'work',
        'wrung'             => 'wring',
    }

    #
    class Rule
      attr :type

      attr :suffix

      attr :suffix1

      attr :suffix2

      # Processing Order
      attr :order

      # McIlroy's Rule Number
      attr :number

      def initialize(type, suffix, suffix1, suffix2, order, number)
        @type    = type
        @suffix  = suffix
        @suffix1 = suffix1
        @suffix2 = suffix2
        @order   = order
        @number  = number
      end

      def <=>(other)
        order <=> other.order
      end
    end

    # Suffix Rules
    RULES = {}

    # Long rule (longest prefix). (0)
    def self.long_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:long, suffix, suffix1, suffix2, order, number)
    end

    # Longer Rule (2nd longest prefix). (1)
    def self.second_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:second, suffix, suffix1, suffix2, order, number)
    end

    # Short Rule. (-1)
    def self.short_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:short, suffix, suffix1, suffix2, order, number)
    end

    # Letter rule. (-2)
    def self.letter_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:letter, suffix, suffix1, suffix2, order, number)
    end

    # Special rule. (-3)
    def self.special_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:special, suffix, suffix1, suffix2, order, number)
    end

    # Use the original string. (-4)
    def self.ditto_rule(suffix, suffix1, suffix2, order, number)
      RULES[suffix] = Rule.new(:ditto, suffix, suffix1, suffix2, order, number)
    end

    long_rule 'hes'        , ''      , '', 1011, '1'
    long_rule 'ses'        , ''      , '', 1021, '2'
    long_rule 'xes'        , ''      , '', 1031, '3'
    long_rule 'zes'        , ''      , '', 1041, '4'
    long_rule 'es'         , ''      , '', 1057, '13b'
    long_rule 'er'         , ''      , '', 1111, '11'
    long_rule 'ed'         , ''      , '', 1122, '12b' # There is extra code for 12b below.

    short_rule 'iless'     , 'y'     , '', 1051, '43a'
    short_rule 'less'      , ''      , '', 1052, '43b'
    short_rule 'iness'     , 'y'     , '', 1053, '44a'
    short_rule 'ness'      , ''      , '', 1054, '44b'
    short_rule "'s"        , ''      , '', 1055, '7'  
    short_rule 'ies'       , 'y'     , '', 1056, '13a'
    short_rule 's'         , ''      , '', 1062, '6b'
    short_rule 'ier'       , 'y'     , '', 1101, '10'
    short_rule 'ied'       , 'y'     , '', 1121, '12a'
    short_rule 'iest'      , 'y'     , '', 1141, '14a'
    short_rule 'bility'    , 'ble'   , '', 1144, '22'
    short_rule 'fiable'    , 'fy'    , '', 1145, '23'
    short_rule 'logist'    , 'logy'  , '', 1146, '24'
    short_rule 'graphic'   , 'graphy', '', 1251, '25'
    short_rule 'istic'     , 'ist'   , '', 1261, '26'
    short_rule 'itic'      , 'ite'   , '', 1271, '27'
    short_rule 'like'      , ''      , '', 1281, '28'
    short_rule 'logic'     , 'logy'  , '', 1291, '29'
    short_rule 'ment'      , ''      , '', 1301, '30'
    short_rule 'mental'    , 'ment'  , '', 1311, '31'
    short_rule 'nce'       , 'nt'    , '', 1331, '33'
    short_rule 'ncy'       , 'nt'    , '', 1341, '34'
    short_rule 'ship'      , ''      , '', 1351, '35'
    short_rule 'ical'      , 'ic'    , '', 1361, '36'
    short_rule 'ional'     , 'ion'   , '', 1371, '37'
    short_rule 'bly'       , 'ble'   , '', 1381, '38'
    short_rule 'ily'       , 'y'     , '', 1391, '39'
    short_rule 'ly'        , ''      , '', 1401, '40'
    short_rule 'iful'      , 'y'     , '', 1411, '41a'
    short_rule 'ful'       , ''      , '', 1412, '41b'
    short_rule 'ihood'     , 'y'     , '', 1421, '42a'
    short_rule 'hood'      , ''      , '', 1422, '42b'
    short_rule 'ification' , 'ify'   , '', 1451, '45'
    short_rule 'ization'   , 'ize'   , '', 1461, '46'
    short_rule 'ction'     , 'ct'    , '', 1471, '47'
    short_rule 'rtion'     , 'rt'    , '', 1481, '48'
    short_rule 'ation'     , 'ate'   , '', 1491, '49'
    short_rule 'ator'      , 'ate'   , '', 1501, '50'
    short_rule 'ctor'      , 'ct'    , '', 1511, '51'
    short_rule 'ive'       , 'ion'   , '', 1521, '52'
    short_rule 'onian'     , 'on'    , '', 1530, '54'
    short_rule 'an'        , 'a'     , '', 1531, '53'

    ditto_rule 'ss'        , ''      , '', 1061, '6a'
    ditto_rule 'ater'      , ''      , '', 1081, '8'
    ditto_rule 'cter'      , ''      , '', 1091, '9'
    ditto_rule 'blity'     , ''      , '', 1143, '21'
    ditto_rule 'cable'     , ''      , '', 1201, '20a'
    ditto_rule 'gable'     , ''      , '', 1202, '20b'

    letter_rule 'est'      , 'e'     , '', 1142, '14b'
    letter_rule 'ing'      , 'e'     , '', 1151, '15'    # There is extra code for 15 below.
    letter_rule 'ist'      , 'e'     , '', 1161, '16'
    letter_rule 'ism'      , 'e'     , '', 1171, '17'
    letter_rule 'ity'      , 'e'     , '', 1181, '18'
    letter_rule 'ize'      , 'e'     , '', 1191, '19'
    letter_rule 'able'     , 'e'     , '', 1203, '20c'

    special_rule 'metry'   , 'meter' , 'metre', 1321, '32'

    # List of rule suffixes in processing order.
    RULE_ORDER = RULES.values.sort.map{ |rule| rule.suffix }

    # Returns the affinative and any acceptable alternatives.
    def self.inifinitive(word)
      information(word)[1]
    end

    # Returns the infinative and any acceptable alternatives.
    def self.infinitives(word)
      information(word)[1..-1]
    end

    IRREGULAR_RULE = Rule.new(:irregular, '', '', '', '', 'irregular')

    # Return the rule applies and all viable infinitive forms of the given +word+.
    def self.information(word)
      word  = word.to_s
      word1 = word2 = suffix = rule = newword = ''

      if IRREGULAR.key?(word)
        word1 = IRREGULAR[word]
        word2 = nil
        rule  = IRREGULAR_RULE
      else
        prefixes = prefixes(word)
        rule = rule(word, prefixes)

        $stderr.puts "prefixes: %p" % prefixes if $DEBUG

        if rule
          suffix = rule.suffix

          $stderr.puts "Using rule %p (%p) for suffix %p" % 
              [rule.number, rule.type, rule.suffix] if $DEBUG

          case rule.type #shortest_prefix
          when :long
            word1 = prefixes[suffix][0]
            word2 = prefixes[suffix][1]
          when :short
            word1 = prefixes[suffix].last + rule.suffix1
            word2 = ''
          when :letter
            word1 = prefixes[suffix].last + rule.suffix1
            word2 = prefixes[suffix].last
          when :special
            word1 = prefixes[suffix].last + rule.suffix1
            word2 = prefixes[suffix].last + rule.suffix2
          when :ditto
            word1 = word
            word2 = ''
          else
            raise IndexError, "Couldn't find rule for shortest prefix %p" %  rule.type #shortest_prefix
          end

          $stderr.puts "For %p: word1: %p, word2: %p" % [rule.type, word1, word2] if $DEBUG

          # Rules 12b and 15: Strip off 'ed' or 'ing'.
          if rule.number == '12b' or rule.number == '15'
            # Do we have a monosyllable of this form:
            # o 0+ Consonants
            # o 1+ Vowel
            # o    2 Non-wx
            # Eg: tipped => tipp?
            # Then return tip and tipp.
            # Eg: swimming => swimm?
            # Then return tipswim and swimm.
            if /^([^aeiou]*[aeiou]+)([^wx])\2$/ =~ word2
              word1 = $1 + $2
              word2 = $1 + $2 + $2
            end
          end
        else
          word1 = word
          word2 = nil
          rule  = IRREGULAR_RULE
        end
      end

      return rule, word1, word2
    end

    # Lookup the rule that applies to a given word.
    def self.rule(word, prefixes=nil)
      prefixes = prefixes(word) unless prefixes

      if IRREGULAR.key?(word)
        IRREGULAR_RULE
      else
        # Build up prefix[suffix] as an array of prefixes, from longest to shortest.
        prefix, suffix = nil, nil
        prefixes = Hash.new{ |h,k| h[k] = [] }
        # Build the hash of prefixes for the word
        1.upto(word.length) do |i|
          prefix = word[0, i]
          suffix = word[i..-1]
          (suffix.length - 1).downto(0) do |j|
            newword = prefix + suffix[0,j]
            prefixes[suffix].push(newword)
          end
        end
        # Now check for rules covering the prefixes for this word, picking
        # the first one if one was found.
        suffix = (RULE_ORDER & prefixes.keys).first
        if suffix
          RULES[suffix]
        else
          IRREGULAR_RULE
        end
      end
    end

    # Calculate the prefixes for a given word.
    def self.prefixes(word)
      # Build up prefix[suffix] as an array of prefixes, from longest to shortest.
      prefix, suffix = nil, nil
      prefixes = Hash.new{ |h,k| h[k] = [] }
      # Build the hash of prefixes for the word
      1.upto(word.length) do |i|
        prefix = word[0, i]
        suffix = word[i..-1]
        (suffix.length - 1).downto(0) do |j|
          newword = prefix + suffix[0,j]
          prefixes[suffix].push(newword)
        end
      end
      return prefixes
    end

  end #class Infinitve

  # Return a list of possible infinitive forms of the given word.
  def self.infinitives(word)
    Infinitive.infinitives(word)
  end

  # Return the infinitive form of the given word.
  def self.infinitive(word)
    Infinitive.infinitives(word).first
  end

  # Return a list of possible infinitive forms of a word.
  def infinitives
    Infinitive.infinitives(@self)
  end

  # Return the infinitive form of a word.
  def infinitive
    Infinitive.infinitives(@self).first
  end

end

