////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMInteger_Private.hpp"
#import "RLMProperty.h"

@implementation RLMInteger

- (instancetype)init {
    if (self = [super init]) {
        _value = 0;
    }
    return self;
}

- (void)incrementValue:(NSInteger)value {
    _value += value;
}

@end

@implementation RLMNullableInteger

- (instancetype)init {
    if (self = [super init]) {
        _value = @0;
    }
    return self;
}

- (void)incrementValue:(NSInteger)value {
    _value = @(_value.integerValue + value);
}

@end

@interface RLMIntegerView () {
    realm::Row _row;
    size_t _colIndex;
}
@end

@implementation RLMIntegerView

- (instancetype)initWithRow:(realm::Row)row columnIndex:(size_t)colIndex {
    if (self = [super init]) {
        _row = row;
        _colIndex = colIndex;
    }
    return self;
}

- (void)setValue:(NSInteger)value {
    _row.get_table()->set_int(_colIndex, _row.get_index(), value, false);
}

- (NSInteger)value {
    return _row.get_table()->get_int(_colIndex, _row.get_index());
}

- (void)incrementValue:(NSInteger)value {
    _row.get_table()->add_int(_colIndex, _row.get_index(), value);
}

@end

@interface RLMNullableIntegerView () {
    realm::Row _row;
    size_t _colIndex;
}
@end

@implementation RLMNullableIntegerView

- (instancetype)initWithRow:(realm::Row)row columnIndex:(size_t)colIndex {
    if (self = [super init]) {
        _row = row;
        _colIndex = colIndex;
    }
    return self;
}

- (void)setValue:(NSNumber<RLMInt> *)value {
    if (value) {
        _row.get_table()->set_int(_colIndex, _row.get_index(), value.longLongValue, false);
    } else {
        _row.get_table()->set_null(_colIndex, _row.get_index());
    }
}

- (NSNumber<RLMInt> *)value {
    return @(_row.get_table()->get_int(_colIndex, _row.get_index()));
}

- (void)incrementValue:(NSInteger)value {
    _row.get_table()->add_int(_colIndex, _row.get_index(), value);
}

@end
